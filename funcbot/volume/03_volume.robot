*** Settings ***
Suite Setup     User gets auth test project scoped token
Suite Teardown  Clean the volume resources if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/volume_keywords.robot

Library         GabbiLibrary    ${VOLUME_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create a volume and show the volume info
  [Tags]    volume     critical
  Given Volume service is available
  When Create a volume
  and Check if the volume is available
  Then Show the volume info

Check if the created volume is in volume list
  [Tags]    volume     critical
  Given Volume service is available
  When Check if the created volume is in volume list

Resize the volume
  [Tags]    volume
  Given Volume service is available
  When Resize the volume
  Then Check if the volume is resized

Update the volume name
  [Tags]    volume     critical
  Given Volume service is available
  When Update the volume name
