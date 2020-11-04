*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the image if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/image_keywords.robot

Library         GabbiLibrary    ${IMAGE_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Create an image and upload image data
  [Tags]    image
  Given Image service is available
  When Create an image 
  Then Upload the image data

Check if the created image is in image list and active
  [Tags]    image
  Given Image service is available
  When Check if the created image is in image list and active

Update the image name
  [Tags]    image
  Given Image service is available
  When Update the image name

Delete the image
  [Tags]    image
  Given Image service is available
  When Delete the image
  Then The image is gone
