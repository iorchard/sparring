#!/bin/bash

# Get robotframework version
RF_VERSION=$(python -m pip show robotframework  |grep Version: |cut -d':' -f2 |tr -d ' ')
# Get sparring version
SPARRING_VERSION=$(git describe --tags --abbrev=0 2>/dev/null)
docker build -t jijisa/sparring .
docker tag jijisa/sparring jijisa/sparring:${SPARRING_VERSION}-${RF_VERSION}
docker push jijisa/sparring
docker push jijisa/sparring:${SPARRING_VERSION}-${RF_VERSION}
