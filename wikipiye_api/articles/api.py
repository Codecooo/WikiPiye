from .services import chosen_facts_fyi
from ninja import Router
from django.shortcuts import get_object_or_404
from django.db import transaction
from django.db.models import F, Q
from ninja.errors import HttpError
from ninja_jwt.authentication import JWTAuth
from users.models import UserRole
from .models import Article, ArticleEdit, ArticleSection, EditProtectionLevel
from .schema import ArticleOut, ArticleCreateIn, ArticleUpdateIn, DetailArticleOut

router = Router()


@router.get("/search", response=list[ArticleOut])
def search_articles(request, query: str, limit: int = 10):
    query = query.strip()
    if not query:
        return []

    query_lower = query.lower()

    candidate_articles = list(
        Article.objects.filter(title__icontains=query)[:50]
    )

    def get_priority(article):
        title_lower = article.title.lower()
        if title_lower == query_lower:
            return 1  # Exact match
        elif title_lower.startswith(query_lower):
            return 2  # Prefix match
        return 3      # Contains match

    candidate_articles.sort(key=lambda a: (get_priority(a), a.title))
    return candidate_articles[:limit]


@router.get("/featured-news", response=list[ArticleOut])
def get_featured_articles(request):
    """
    Mengambil daftar artikel featured dan berita hari ini yang ditampilkan sebagai berita utama.
    """
    articles = Article.objects.filter(Q(is_featured=True) | Q(is_in_the_news=True))
    return articles


@router.get("/trending", response=list[ArticleOut])
def get_trending_articles(request):
    """
    Mengambil daftar artikel yang sedang tren berdasarkan view_count.
    """
    articles = Article.objects.order_by('-view_count')[:10]
    return articles
    

@router.post("", response=ArticleOut, auth=JWTAuth())
@transaction.atomic
def create_article(request, payload: ArticleCreateIn):
    """
    Membuat artikel baru beserta sections-nya (Atomic).
    """
    data = payload.dict(exclude_none=True)
    sections_data = data.pop("sections", [])

    article = Article.objects.create(**data)

    for sec in sections_data:
        ArticleSection.objects.create(article=article, **sec)

    return get_object_or_404(Article.objects.prefetch_related('sections'), id=article.id)


@router.put("/{article_id}", response=DetailArticleOut)
@transaction.atomic
def edit_article(request, article_id: int, payload: ArticleUpdateIn):
    """
    Mengedit atribut utama artikel berdasarkan ID.
    """
    article = get_object_or_404(Article.objects.prefetch_related('sections'), id=article_id)
    
    user = getattr(request, 'user', None) or request.auth
    
    if article.edit_protection_level == EditProtectionLevel.FULL:
        raise HttpError(403, "Artikel ini dilindungi penuh dan tidak dapat diedit.")
    elif article.edit_protection_level == EditProtectionLevel.SEMI:
        if not user or getattr(user, 'user_role', None) != UserRole.EDITOR:
            raise HttpError(403, "Artikel ini dilindungi sebagian dan hanya dapat diedit oleh editor.")
    
    update_data = payload.dict(exclude_unset=True)
    edit_title = update_data.pop("edit_title", "Suntingan Artikel")
    edit_summary = update_data.pop("edit_summary", "")

    for field, value in update_data.items():
        setattr(article, field, value)
    article.save()

    if user.is_authenticated:
        ArticleEdit.objects.create(
            article=article,
            editor=user,
            edit_title=edit_title,
            edit_summary=edit_summary
        )
    else:
        ArticleEdit.objects.create(
            article=article,
            editor=None,
            editor_ip_address=request.client.host,
            edit_title=edit_title,
            edit_summary=edit_summary
        )

    return article


@router.get("/{article_id}", response=DetailArticleOut)
def get_article(request, article_id: int):
    """
    Mengambil artikel berdasarkan ID beserta sections-nya.
    """
    article = get_object_or_404(Article.objects.prefetch_related('sections'), id=article_id)
    
    Article.objects.filter(id=article_id).update(view_count=F('view_count') + 1)
    article.refresh_from_db(fields=['view_count'])
    
    return article


@router.get("/fyi/facts", response=list[str])
def get_random_facts(request):
    """
    Mengambil daftar 10 fakta acak untuk ditampilkan di halaman utama.
    """
    return chosen_facts_fyi()