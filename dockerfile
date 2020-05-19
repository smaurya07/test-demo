FROM python:3.7-alpine
LABEL maintainer="Sudha Maurya"

COPY . /opt/src
WORKDIR /opt/src

# ADD pytest cache and results folder
RUN mkdir -p .pytest_cache/v/cache results
RUN echo "{}" > .pytest_cache/v/cache/lastfailed
RUN chmod -R 777 .pytest_cache/ results/

# install gcc and others as alpine image doesn't have cryptographic libs
RUN apk add --virtual .build-deps gcc musl-dev libffi-dev openssl-dev git

# install poetry, and project dependencies
RUN pip --no-cache-dir install poetry poetry-setup
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev
