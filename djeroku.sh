#!/bin/bash

#Ensuring correct file name
if [ -z "$1" ]
 then 
  echo "Give a name to your project - All lowercase"
else
if [[ $1 =~ [A-Z] ]]
  then
    echo "Please use all lowercase project name"
elif [[ $1 == *['!'@#\$%^\&-*()+]* ]]
  then 
    echo "Please use all lowercase project name"
elif [[ $1 =~ [0-9] ]]
then
    echo "Please use all lowercase project name"
else

#Create virtual env and activate
python3 -m pip install --user virtualenv
python3 -m virtualenv $1
source $1/bin/activate
cd $1

#Create django project
pip install django
django-admin startproject $1
cd $1
#Create testPage webpage
python manage.py startapp testPage
cd testPage

#Edit views.py file
rm views.py
echo "from django.shortcuts import render
# Create your views here.
from django.http import HttpResponse
def index(request):
    return HttpResponse(\"Hello, world. A test page by Harish M.\")" > views.py

#Create urls.py for the testPage
echo "from django.urls import path
from . import views
urlpatterns = [
    path('', views.index, name='index'),
]" > urls.py

#Edit root directory urls.py
cd ..
cd $1
rm urls.py
echo "from django.contrib import admin
from django.urls import include, path
urlpatterns = [
    path('', include('testPage.urls')),
    path('admin/', admin.site.urls),
]" > urls.py

#Login to Heroku
cd ..
heroku login

#Create procfile for the heroku
proc1="web: gunicorn "
proc2=".wsgi --log-file -" 
proc="$proc1$1$proc2"
echo $proc > Procfile

#Create requirements file
echo "django
gunicorn
django-heroku" > requirements.txt

#Edit settings for the heroku file
cd $1
echo "import django_heroku
django_heroku.settings(locals())" >> settings.py
cd ..

#Initialize git
git init
git add .
git commit -m "Initial"

#Create Heroku app
heroku create $1

#Push and start app
git push heroku master
heroku ps:scale web=1
heroku open

#Deactivate virtualEnv
deactivate
cd ~

fi
fi
