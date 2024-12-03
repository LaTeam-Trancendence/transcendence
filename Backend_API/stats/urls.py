from django.urls import path
<<<<<<< HEAD
from .views import FinalizeMatchView
=======
from .views import FinalizeMatchView, ShowStat
>>>>>>> main


# \\_______________________________________________//

urlpatterns = [
    path('match/', FinalizeMatchView.as_view(), name='listmatch'),
    path('match/<int:match_id>/', FinalizeMatchView.as_view(),
<<<<<<< HEAD
         name='statMatch')    
=======
         name='statMatch'),
    path('stat/', ShowStat.as_view(), name='stat')
>>>>>>> main
]
