*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the network if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/network_keywords.robot

Library         GabbiLibrary    ${IDENTITY_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create a router and show the router info
  [Tags]    network     critical
  Given Network service is available
  When Create a router
  Then Show the router info

Check if the created router is in router list
  [Tags]    network     critical
  Given Network service is available
  When Check if the created router is in router list

Add an interface to the router
  [Tags]    network     critical
  Given Network service is available
  When Add an interface to the router

Set an external gateway to the router
  [Tags]    network     critical
  Given Network service is available
  When Set an external gateway to the router
