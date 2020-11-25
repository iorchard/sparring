*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the compute resources if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/compute_keywords.robot

Library         GabbiLibrary    ${COMPUTE_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create a flavor
  [Tags]    compute     critical
  Given Compute service is available
  When Create a flavor

Check if the created flavor is in flavor list
  [Tags]    compute     critical
  Given Compute service is available
  When Check if the created flavor is in flavor list

Show the flavor info
  [Tags]    compute     critical
  Given Compute service is available
  When Show the flavor info
 
