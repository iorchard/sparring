*** Settings ***
Suite Setup         Log into ssh host
Suite Teardown      SSHLibrary.Close All Connections

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/cdbot_resources.robot

*** Test Cases ***
Pre-Process
  [Tags]        pre
  [Template]    Check prerequisites
  # service_name
  identity

Test Rolling Update
  [Tags]        main
  [Template]    Test rolling update
  # service_name
  identity

Post Process
  [Tags]     post
  Log   Clean up again
  [Teardown]    Stop sending requests
