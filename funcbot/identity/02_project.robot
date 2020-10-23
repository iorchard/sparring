*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the project
Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot

Library         GabbiLibrary    ${IDENTITY_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
List all projects
  [Tags]    identity
  Given Identity service is available
  When List all projects

Create a project and show the project info
  [Tags]    identity
  Given Identity service is available
  When Create a project
  Then Show the project info

Rename the project
  [Tags]    identity 
  Given Identity service is available
  When Rename the project

Delete the project
  [Tags]    identity 
  Given Identity service is available
  When Delete the project
  Then The project is gone
