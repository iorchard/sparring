*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the compute resources if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/compute_keywords.robot

Library         GabbiLibrary    ${COMPUTE_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create an aggregate
  [Tags]    compute     critical
  Given Compute service is available
  When Create an aggregate

Check if the created aggregate is in aggregate list
  [Tags]    compute     critical
  Given Compute service is available
  When Check if the created aggregate is in aggregate list

Add a host to the aggregate
  [Tags]    compute     critical
  Given Compute service is available
  When Add a host to the aggregate

Update the aggregate 
  [Tags]    compute     critical
  Given Compute service is available
  When Update the aggregate

Show the aggregate info
  [Tags]    compute     critical
  Given Compute service is available
  When Show the aggregate info

Remove a host from the aggregate
  [Tags]    compute     critical
  Given Compute service is available
  When Remove a host from the aggregate

