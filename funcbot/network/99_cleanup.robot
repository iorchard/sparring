*** Settings ***
Suite Setup     User gets auth token

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/network_keywords.robot

Library         GabbiLibrary    ${IDENTITY_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Clean all network resources
  [Tags]    network
  Clean network resources
