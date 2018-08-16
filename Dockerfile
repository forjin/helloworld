# To reduce container registry size alpine based image is the best.
# And this can save build time as well.
FROM python:3.7.0-alpine3.8

RUN mkdir /app /dependancy
# To reduce rebuild image everytime this seperation is needed
# Same things can be applied package.json or yarn.lock for node application
COPY ./requirements.txt /dependancy
WORKDIR /dependancy
RUN pip install -r requirements.txt
# Copy all the sourcefile to application folder
# .dockerignore can handle ignoring file such as README or some unnessary files.
WORKDIR /app
RUN mv /dependancy/* /app
COPY ./src /app

# port exposure can give some help to which container port should be opened.
EXPOSE 5000

ENTRYPOINT [ "python", "/app/web_app.py" ]