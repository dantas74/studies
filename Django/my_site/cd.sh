#!/bin/bash

python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py collectstatic --noinput

## Important ##
# All apps must be zipped
zip -r project.zip requirements.txt manage.py custom_storages.py my_site/ uploads/ templates/ staticfiles/ blog/ .ebextensions/
