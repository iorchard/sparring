*** Settings ***
Library             OperatingSystem
# Replace String is used in resources/image_keywords.yaml
Library             String
Library             Collections

*** Variables ***
# path relative robot file where gabbi test files are located
${GABBIT_PATH}       ${CURDIR}/../gabbits
