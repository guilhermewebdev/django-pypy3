FROM pypy:3

WORKDIR /usr/share/django

RUN pip install --upgrade pip; \
    mkdir /var/lib/django; \
    useradd -U -d /var/lib/django django; 

COPY . .

RUN chmod -R 740 /usr/share/django/; \
    chown -R django:django /usr/share/django/; \
    chown -R django:django /var/lib/django; \
    chmod -R 740 /var/lib/django/;

USER django

ENV PATH /var/lib/django/.local/bin:$PATH

RUN pip install -r requirements.txt --user;

CMD [ "pypy3", "manage.py", "runserver", "0.0.0.0:8000" ]