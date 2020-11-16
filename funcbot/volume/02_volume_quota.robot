*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the volume resources if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/volume_keywords.robot

Library         GabbiLibrary    ${VOLUME_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Update volume quota for the project
  [Tags]    volume      critical
  Given Volume service is available
  When Update volume quota for the project
  Then Check if the volume quota is set

