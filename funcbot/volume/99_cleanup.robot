*** Settings ***
Suite Setup     User gets auth token

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/image_keywords.robot
Resource        ${EXECDIR}/../resources/volume_keywords.robot

Library         GabbiLibrary    ${VOLUME_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Clean all volume resources
  [Tags]    volume  clean
  Clean volume resources
  Clean image resources
  Clean the project
