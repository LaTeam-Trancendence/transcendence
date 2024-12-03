from django.urls import path
<<<<<<< HEAD
from .views import statsPlayerView
=======
from .views import statsPlayerView, UploadPlayerImageView
>>>>>>> main


# \\_______________________________________________//

urlpatterns = [
    path('players/', statsPlayerView.as_view(), name='listPlayer'),
    path('players/<int:player_id>/', statsPlayerView.as_view(), 
<<<<<<< HEAD
         name='statPlayers')    
=======
         name='statPlayers'),
    path('image/', UploadPlayerImageView.as_view(), name='imagePlayer')
>>>>>>> main
]
