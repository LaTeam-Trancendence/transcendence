from django.shortcuts import render
from django.http import JsonResponse
from rest_framework.views import APIView
from rest_framework.permissions import AllowAny
<<<<<<< HEAD
from django.contrib.auth import authenticate, login
from register.utils import CustomResponse
from register.serializers import UserSerializer , LoginSerializer
from Back import settings
=======
from django.contrib.auth import authenticate, login, logout
from register.utils import CustomResponse
from register.serializers import UserSerializer , LoginSerializer
from django.views.decorators.csrf import csrf_exempt
from Back import settings
import logging
>>>>>>> main


# \\_________________register___________________________________//

<<<<<<< HEAD

class RegisterUserView(APIView):
    permission_classes = [AllowAny] 
    
=======
logger = logging.getLogger(__name__)

class RegisterUserView(APIView):
    permission_classes = [AllowAny]

>>>>>>> main
    def get(self, request, *args, **kwargs):    #test request Get
        return CustomResponse.success({
            "status": "success",
            "message": "Veuillez envoyer une requête POST pour vous inscrire.",
        }, status_code=200)
<<<<<<< HEAD
    
    def post(self, request, *args, **kwargs):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            return(CustomResponse.succes(
                data = {"CustomUser": UserSerializer(user).Meta},
                message="succes",
                status_code=201
            ))
        return(CustomResponse.error(
            errors=serializer.errors,
            message="error",
            status_code=400
        ))

# \\ ___________________login___________________________________//

class LoginView(APIView):
      
=======

    def post(self, request, *args, **kwargs):
        data=request.data
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            return(CustomResponse.success(
                {"CustomUser": "create"},
                status_code=201
            ))
        return(CustomResponse.error(
            {"errors": serializer.errors},
            status_code=400
        ))

# @csrf_exempt
# class HealthCheckView(APIView):
#     permission_classes = [AllowAny]

#     def get(self, request):
#         return (CustomResponse.success(
#             {"status": "ok"},
#             status_code=200
#         ))

# \\ ___________________login___________________________________//


class LoginView(APIView):
    permission_classes = [AllowAny]

>>>>>>> main
    def post(self, request, *args, **kwargs):

        serializer = LoginSerializer(data=request.data)
        if serializer.is_valid():
            username = serializer.validated_data.get('username')
            password = serializer.validated_data.get('password')

            user = authenticate(request, username=username, password=password)

            if user is not None:
                login(request, user)
<<<<<<< HEAD
                return(CustomResponse.succes(
                    data = {"CustomUser": UserSerializer(user).Meta},
                    message="succes",
=======
                return(CustomResponse.success(
                    {"CustomUser": "success login"},
>>>>>>> main
                    status_code=200
            ))
            else:
                return(CustomResponse.error(
<<<<<<< HEAD
                    errors=serializer.errors,
                    message="error",
                    status_code=400
        ))
        else:
            return(CustomResponse.error(
                errors=serializer.errors,
                message="error",
                status_code=401
        ))

def anoCustomUser(user):
    
    user.username = f"user_{user.id}"
    user.image = None 
    user.save()
    
class DeleteAccountView(APIView):
    
    def post(self, request, *args, **kwargs):

        user = request.user
        
        if user:
            anoCustomUser(user)
            return(CustomResponse.succes(
                data = {"CustomUser": UserSerializer(user).Meta},
                message="anonimisation reussie",
=======
                {"errors": serializer.errors},
                status_code=400
        ))
        else:
            return(CustomResponse.error(
                {"errors": serializer.errors},
                status_code=401
        ))


 # \\___________________logout________________________//


class LogoutView(APIView):

    def post(self, request):

        logout(request)
        return (CustomResponse.success(
            {"message": "Déconnexion réussie."},
            status=200
        ))


 # \\_________________Anonim________________________//


def anoCustomUser(user):

    user.username = f"user_{user.id}"
    user.image = None
    user.save()

class DeleteAccountView(APIView):

    def post(self, request, *args, **kwargs):

        user = request.user

        if user:
            anoCustomUser(user)
            return(CustomResponse.succes(
                {"delete":"anonimisation reussie"},
>>>>>>> main
                status_code=200
            ))
        else:
            return(CustomResponse.error(
<<<<<<< HEAD
                errors=anoCustomUser.errors,
                message="error",
                status_code=400
        ))
            
            
            
            
            
            
            
# class DeleteAccountView(APIView):
    
#     def delete(self, request, *args, **kwargs):
        
=======
                {"errors": anoCustomUser.errors},
                status_code=400
        ))





# class DeleteAccountView(APIView):

#     def delete(self, request, *args, **kwargs):

>>>>>>> main
#         user = request.user
#         if user.is_authenticated:
#             anonymize_and_delete_user(user)
#             return Response({"message": "Votre compte a été supprimé et anonymisé."}, status=200)
#         return Response({"error": "Utilisateur non authentifié."}, status=401)