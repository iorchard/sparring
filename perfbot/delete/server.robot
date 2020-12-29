*** Settings ***
Suite Setup     User gets auth token

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot

Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/network_keywords.robot
Resource        ${EXECDIR}/../resources/volume_keywords.robot
Resource        ${EXECDIR}/../resources/compute_keywords.robot

Library         GabbiLibrary    ${COMPUTE_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Delete Servers
  [Tags]    delete
  Given Compute Service is available
  When Delete servers
  Then All servers are gone

Clean ports
  [Tags]    delete
  Clean the ports

