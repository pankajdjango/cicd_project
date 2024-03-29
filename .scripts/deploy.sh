#!/bin/bash
set -e

echo "Deployment started ..."

# Pull the latest version of the app
git pull origin master
echo "New changes copied to server !"

# Activate Virtual Env
source /home/django-server/env/bin/activate
echo "Virtual env 'env' Activated !"

echo "Installing Dependencies..."
pip install -r requirements.txt --no-input

echo "Serving Static Files..."
python manage.py collectstatic --noinput

echo "Running Database migration"
python manage.py makemigrations
python manage.py migrate

# Deactivate Virtual Env
deactivate
echo "Virtual env 'env' Deactivated !"

# Restart Apache (if using Apache)
echo "Restarting Apache..."
touch emp_crud/wsgi.py

# Check Apache status
# echo "Checking Apache status..."
# touch emp_crud/wsgi.py

echo "Deployment Finished!"
