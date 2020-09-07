FROM pypy:3

RUN pip install --upgrade pip; \
    useradd -U -d /var/lib/django django; \
    mkdir /usr/share/django; 

COPY . /usr/share/django/

RUN chmod -R 540 /usr/share/django/; \
    chown -R django:django /usr/share/django/; \
    chmod -R 740 /var/lib/django/;

USER django

ENV PATH /var/lib/django/.local/bin:$PATH

RUN pip install -r requirements.txt --user;

CMD [ "pypy3", "manage.py", "runserver", "0.0.0.0:8000" ]