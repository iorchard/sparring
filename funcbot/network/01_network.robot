*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the network if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/network_keywords.robot

Library         GabbiLibrary    ${NETWORK_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create a network and show the network info
  [Tags]    network     critical
  Given Network service is available
  When Create a network
  Then Show the network info

Check if the created network is in network list
  [Tags]    network     critical
  Given Network service is available
  When Check if the created network is in network list

Rename the network name
  [Tags]    network     critical
  Given Network service is available
  When Rename the network name

Create a subnet and show the subnet info
  [Tags]    network     critical
  Given Network service is available
  When Create a subnet
  Then Show the subnet info

Check if the created subnet is in subnet list
  [Tags]    network     critical
  Given Network service is available
  When Check if the created subnet is in subnet list

Rename the subnet name
  [Tags]    network     critical
  Given Network service is available
  When Rename the subnet name

