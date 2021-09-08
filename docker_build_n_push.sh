#!/bin/bash

docker build -t jijisa/sparring .
docker tag jijisa/sparring jijisa/sparring:train
docker push jijisa/sparring
docker push jijisa/sparring:train
