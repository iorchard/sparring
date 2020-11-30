*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the compute resources if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/compute_keywords.robot

Library         GabbiLibrary    ${COMPUTE_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Update the quotas for a project
  [Tags]    compute     critical
  Given Compute service is available
  and Create a project
  and Assign the admin role to admin user on project
  When Update the quotas for a project

Check if the quotas are updated
  [Tags]    compute     critical
  Given Compute service is available
  When Check if the quotas are updated
