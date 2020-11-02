*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the network if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/network_keywords.robot

Library         GabbiLibrary    ${IDENTITY_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create a floating ip and show the floating ip info
  [Tags]    network
  Given Network service is available
  When Create a floating ip
  Then Show the floating ip info

Check if the created floating ip is in floating ip list
  [Tags]    network     
  Given Network service is available
  When Check if the created floating ip is in floating ip list

Update the floating ip description
  [Tags]    network
  Given Network service is available
  When Update the floating ip description

