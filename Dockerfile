FROM pypy:3

WORKDIR /var/www/django

RUN pip install --upgrade pip; \
    mkdir /var/lib/django; \
    useradd -U -d /var/lib/django django; \
    chmod -R 740 /var/www/django/; \
    chown -R django:django /var/www/django/; \
    chown -R django:django /var/lib/django; \
    chmod -R 740 /var/lib/django/;

USER django

ENV PATH /var/lib/django/.local/bin:$PATH

RUN pip install Django --user;

RUN django-admin startproject -v 3 app .;

CMD [ "pypy3", "manage.py", "runserver", "0.0.0.0:8000" ]

VOLUME [ "/var/www/django" ]