*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the network if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/network_keywords.robot

Library         GabbiLibrary    ${IDENTITY_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Update the network quota
  [Tags]    network
  Given Network service is available
  When Create a project
  Then Update the network quota

Check if the network quota is set
  [Tags]    network
  Given Network service is available
  When Check if the network quota is set
  Then Delete the project
