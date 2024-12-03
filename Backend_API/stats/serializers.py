from rest_framework import serializers
from tables_core.models import CustomUser, Player, Match
from player.serializers import PlayerSerializer


# \\ _______________________________________________//


class MatchSerializer(serializers.ModelSerializer):
    user = PlayerSerializer(read_only=True) 
    adv = PlayerSerializer(read_only=True) 

    class Meta:
        model = Match
<<<<<<< HEAD
        fields = ['id', 'user',' user_score', 'adv', 'adv_score', 'result',
=======
        fields = ['id', 'user', 'adv', 'user_score', 'adv_score', 'result',
>>>>>>> main
                  'date', 'duration']
