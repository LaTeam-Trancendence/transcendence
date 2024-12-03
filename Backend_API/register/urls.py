from django.urls import path
<<<<<<< HEAD
from .views import RegisterUserView, LoginView
=======
from .views import RegisterUserView, LoginView, LogoutView
>>>>>>> main


# \\_______________________________________________//


urlpatterns = [
    path('register/', RegisterUserView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
<<<<<<< HEAD
=======
    path('logout/', LogoutView.as_view(), name='logout'),
    # path('healthcheck/', HealthCheckView.as_view(), name='healthcheck'),
>>>>>>> main
]