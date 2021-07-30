#I specify the parent base image which is the python version 3.7
FROM python:3.7

# This prevents Python from writing out pyc files
ENV PYTHONDONTWRITEBYTECODE 1
##startr
FROM ubuntu:16.04
FROM python:3.7

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev && \ 
    apt-get install -y curl wget && \
    apt-get install -y default-jre

WORKDIR /app
COPY . /app
RUN pip install -r /app/requirements.txt
RUN pip install /app/lib/datarobot_mlops-7.2.1-py2.py3-none-any.whl 

ARG ENDPOINT=' ENDPOINT'
ARG TOKEN=' API TOKEN'
ARG USERNAME='euclidscott07@gmail.com'
ARG PROJECT_ID='YPROJECT_ID'
ARG MODEL_ID='MODEL_ID'
ARG CHANNEL_CONFIG=' CHANNEL CONFIG'
ARG DEPLOYMENT_ID='  DEPLOYMENT_ID'

ENV DATAROBOT_ENDPOINT=$ENDPOINT
ENV DATAROBOT_API_TOKEN=$TOKEN
ENV USERNAME=$USERNAME
ENV PROJECT_ID=$PROJECT_ID
ENV MODEL_ID=$MODEL_ID
ENV CHANNEL_CONFIG=$CHANNEL_CONFIG
ENV DEPLOYMENT_ID=$DEPLOYMENT_ID

RUN mkdir tmp
CMD python /app/app.py && python /app/datarobot_diabetes.py 

