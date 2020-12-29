*** Settings ***
Suite Setup     User gets auth token
#Suite Teardown  Clean the compute resources if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot

Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/network_keywords.robot
Resource        ${EXECDIR}/../resources/volume_keywords.robot
Resource        ${EXECDIR}/../resources/compute_keywords.robot

Library         GabbiLibrary    ${COMPUTE_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create servers
  [Tags]    create
  Given Compute service is available
  When Create servers
  Then All servers are active
