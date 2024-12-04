from django.urls import path
<<<<<<< HEAD
from .views import statsPlayerView, PlayerUpdateView
=======
from .views import statsPlayerView, UploadPlayerImageView
>>>>>>> main


# \\_______________________________________________//

urlpatterns = [
    path('players/', statsPlayerView.as_view(), name='listPlayer'),
    path('players/<int:player_id>/', statsPlayerView.as_view(), 
         name='statPlayers'),
<<<<<<< HEAD
    path('image/', PlayerUpdateView.as_view(), name='imagePlayer')
=======
    path('image/', UploadPlayerImageView.as_view(), name='imagePlayer')
>>>>>>> main
]
