#I specify the parent base image which is the python version 3.7
FROM python:3.7

MAINTAINER myname <mail@example.com>

# This prevents Python from writing out pyc files
ENV PYTHONDONTWRITEBYTECODE 1
# This keeps Python from buffering stdin/stdout
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apt-get update \
    && apt-get -y install gcc make  \
    && rm -rf /var/lib/apt/lists/*

# install dependencies
RUN pip install --no-cache-dir --upgrade pip

# set work directory
WORKDIR /src/app

# copy project
COPY . .

# copy requirements.txt
COPY ./requirements.txt /src/app/requirements.txt

# install project requirements
RUN pip install --no-cache-dir -r requirements.txt

# Generate pikle file
WORKDIR /src/app/model
RUN python model.py

# set work directory
WORKDIR /src/app

# Run app.py when the container launches
CMD [ "./start.sh"] 
