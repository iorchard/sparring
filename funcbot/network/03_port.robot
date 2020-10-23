*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the network if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/network_keywords.robot

Library         GabbiLibrary    ${IDENTITY_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create a port and show the port info
  [Tags]    network
  Given Network service is available
  When Create a port
  Then Show the port info

Check if the created port is in port list
  [Tags]    network
  Given Network service is available
  When Check if the created port is in port list

Rename the port name
  [Tags]    network
  Given Network service is available
  When Rename the port name

