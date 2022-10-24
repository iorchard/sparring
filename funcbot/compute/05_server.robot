*** Settings ***
Test Setup      Take a rest
Test Teardown   Take a rest
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

Map a floating ip to the server
  [Tags]    compute  critical
  Given Compute service is available
  and Set up a router to map a floating ip to the server
  When Create a floating ip with the server port
  Then Check if the floating ip is active

Check if the floating ip is mapped to the server port
  [Tags]    compute  critical
  Given Compute service is available
  When Check if the floating ip is mapped to the server port
  Then Check if the server has the floating ip

Create an image from the server
  [Tags]    compute     critical
  Given Compute service is available
  When Create an image from the server
  Then Check if the created image from the server is active

Create a volume and attach it to the server
  [Tags]    compute     critical
  Given Compute service is available
  and Create a volume to attach to the server
  When Attach the volume to the server

Check if the volume is attached to the server
  [Tags]    compute     critical
  Given Compute service is available
  When Check if the volume is attached to the server
  Then Check if the server has the volume
