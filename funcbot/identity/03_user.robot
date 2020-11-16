*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the project if test failed
Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot

Library         GabbiLibrary    ${IDENTITY_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create a user and show the user info
  [Tags]    identity    critical
  Given Identity service is available
  When Create a user
  Then Show the user info

Assign the admin role to user on project
  [Tags]    identity    critical
  Given Identity service is available
  When Assign the admin role to user on project
  Then Check if user has the admin role on project
