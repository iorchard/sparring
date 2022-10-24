#!/bin/bash

# Get robotframework version
rf_version=$(python -m pip show robotframework  |grep Version: |cut -d':' -f2 |tr -d ' ')
docker build -t jijisa/sparring .
docker tag jijisa/sparring jijisa/sparring:${rf_version}-yoga
docker push jijisa/sparring
docker push jijisa/sparring:${rf_version}-yoga
