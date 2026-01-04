#!/usr/bin/env bash

# activate the virtual environment
source ~/venv/bin/activate

# cd into the project code
cd /var/www/AWS-Infrastructure-with-Terraform-and-Jenkins

# pull the latest codebase
git pull

# install the app dependencies
pip install -r requirements.txt

# create new migrations based on model changes
python manage.py makemigrations

# run the database migrations
python manage.py migrate --no-input

# run the collect static command
python manage.py collectstatic --no-input

# deactivate the virtual environment
deactivate

# restart gunicorn
sudo systemctl restart gunicorn

# reload nginx
sudo systemctl reload nginx