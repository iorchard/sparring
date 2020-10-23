*** Settings ***
Suite Setup     User gets auth token

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot

Library         GabbiLibrary    ${IDENTITY_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
List all domains
  [Tags]    identity    critical
  Given Identity service is available
  When List all domains

Get the domain info
  [Tags]    identity 
  Given Identity service is available
  When Get the domain info
