FROM pypy:3

RUN pip install --upgrade pip; \
    useradd -Um django; \
    mkdir /home/django/.share; 

COPY . /home/django/.share/

RUN chmod -R 540 /home/django/.share/; \
    chown -R django:django /home/django/.share/; 

USER django

WORKDIR /home/django/.share

ENV PATH /home/django/.local/bin:$PATH

RUN pip install -r requirements.txt --user;

CMD [ "pypy3", "manage.py", "runserver", "0.0.0.0:8000" ]