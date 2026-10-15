from ninja import NinjaAPI
from ninja_jwt.routers.obtain import obtain_pair_router
from auth.api import router as auth_router
from articles.api import router as articles_router

api = NinjaAPI(title="WikiPiye API", version="1.0")

api.add_router(
    "/auth/",
    auth_router,
    tags=["Authentication"]
)

api.add_router(
    "/token/",
    obtain_pair_router,
    tags=["Authentication"]
)

api.add_router(
    "/articles/",
    router=articles_router,
    tags=["Articles"]
)