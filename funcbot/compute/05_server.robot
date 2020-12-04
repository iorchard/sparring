*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the compute resources if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/image_keywords.robot
Resource        ${EXECDIR}/../resources/network_keywords.robot
Resource        ${EXECDIR}/../resources/volume_keywords.robot
Resource        ${EXECDIR}/../resources/compute_keywords.robot

Library         GabbiLibrary    ${COMPUTE_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create a server
  [Tags]    compute     critical
  Given Compute service is available
  and Create a volume and a port for a server
  When Create a server with a port and a volume
  Then Check if the server is active

Check if the created server is in server list
  [Tags]    compute     critical
  Given Compute service is available
  When Check if the created server is in server list

List servers details
  [Tags]    compute     critical
  Given Compute service is available
  When List servers details

Update the server info
  [Tags]    compute     critical
  Given Compute service is available
  When Update the server info

Show the server info
  [Tags]    compute     critical
  Given Compute service is available
  When Show the server info

