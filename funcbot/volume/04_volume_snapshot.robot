*** Settings ***
Suite Setup     User gets auth test project scoped token
Suite Teardown  Clean the volume resources if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/image_keywords.robot
Resource        ${EXECDIR}/../resources/volume_keywords.robot

Library         GabbiLibrary    ${VOLUME_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create a snapshot and show the snapshot info
  [Tags]    volume     critical
  Given Volume service is available
  When Create a snapshot
  and Check if the snapshot is available
  Then Show the snapshot info

Check if the created snapshot is in snapshot list
  [Tags]    volume     critical
  Given Volume service is available
  When Check if the created snapshot is in snapshot list

Update the snapshot name
  [Tags]    volume     critical
  Given Volume service is available
  When Update the snapshot name
