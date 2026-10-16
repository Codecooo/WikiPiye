from ninja import NinjaAPI
from ninja_jwt.routers.obtain import obtain_pair_router
from auth.api import router as auth_router
from articles.api import router as articles_router
from users.api import router as users_router
from reading_lists.api import router as reading_lists_router
from activity.api import router as activity_router

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

api.add_router(
    "/users/",
    router=users_router,
    tags=["Users"]
)

api.add_router(
    "/reading-lists/",
    router=reading_lists_router,
    tags=["Reading Lists"]
)

api.add_router(
    "/activity/",
    router=activity_router,
    tags=["Activity"]
)