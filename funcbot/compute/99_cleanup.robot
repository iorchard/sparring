*** Settings ***
Suite Setup     User gets auth token

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/compute_keywords.robot

Library         GabbiLibrary    ${IMAGE_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Clean all compute resources
  [Tags]    compute
  Clean compute resources
  Clean the project
