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
List hypervisors
  [Tags]    compute     critical
  Given Compute service is available
  When List hypervisors

List hypervisors details
  [Tags]    compute     critical
  Given Compute service is available
  When List hypervisors details

Show details for a hypervisor
  [Tags]    compute     critical
  Given Compute service is available
  When Show details for a hypervisor
 
