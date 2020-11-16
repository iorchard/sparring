*** Settings ***
Suite Setup     User gets auth token

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot

Library         GabbiLibrary    ${IDENTITY_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Clean all project resources
  [Tags]    identity
  Clean project resources

