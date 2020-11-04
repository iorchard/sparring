*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the volume resources if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/volume_keywords.robot

Library         GabbiLibrary    ${VOLUME_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create a volume type and show the volume type info
  [Tags]    volume     critical
  Given Volume service is available
  and Create a project
  When Create a volume type 
  and Set the volume backend of the volume type
  Then Show the volume type info

Check if the created volume type is in volume type list
  [Tags]    volume     critical
  Given Volume service is available
  When Check if the created volume type is in volume type list

Add the volume type to test project
  [Tags]    volume     critical
  Given Volume service is available
  When Add the volume type to test project

Check if the test project has an access to the volume type
  [Tags]    volume     critical
  Given Volume service is available
  When Check if the test project has an access to the volume type

