FROM python:3.7.0-alpine3.8

RUN mkdir /app /dependancy
COPY ./requirements.txt /dependancy
WORKDIR /dependancy
RUN pip install -r requirements.txt
WORKDIR /app
COPY . /app

EXPOSE 5000

ENTRYPOINT [ "python", "/app/web_app.py" ]