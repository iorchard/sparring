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
Upload the volume to image service
  [Tags]    volume     critical
  Given Volume service is available
  When Upload the volume to image service
  and Check if the image from vol is active
  Then Show the image from vol info

Revert the volume to snapshot
  [Tags]    volume  critical
  Given Volume service is available
  and Check if the volume is available
  When Revert the volume to snapshot
  Then Check if the snapshot is available
