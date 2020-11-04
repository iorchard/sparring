*** Keywords ***
# common
Image service is available
  # remove v2 from the url
  ${img_srv} =   Replace String    ${IMAGE_SERVICE}  v2     versions
  connect to image service      IMAGE_SERVICE_VERSIONS=${img_srv}
  ...                           IMAGE_SERVICE=${IMAGE_SERVICE}

Clean the image if test failed
  Run Keyword If Any Tests Failed   Clean image resources

Clean image resources
  # get info from txt file
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/image.txt
  ${test_image_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/image.txt

  Run Keyword And Ignore Error  clean image   url=${IMAGE_SERVICE}
  ...                           TEST_IMAGE_ID=${test_image_id}

  ${path}   ${img_file} =   Split Path  ${TEST_IMAGE_FILE}
  Remove Files      ${GABBIT_PATH}/${img_file}
  ...               ${GABBIT_PATH}/update_image.json

#
# image
#
Create an image
  &{RESP} =     create image        url=${IMAGE_SERVICE}
  ...               TEST_IMAGE_NAME=${TEST_IMAGE_NAME}
  ...               TEST_IMAGE_CONTAINER_FORMAT=${TEST_IMAGE_CONTAINER_FORMAT}
  ...               TEST_IMAGE_DISK_FORMAT=${TEST_IMAGE_DISK_FORMAT}
  Set Environment Variable      TEST_IMAGE_ID  ${RESP.test_image_id}
  Create File    ${TEMPDIR}/image.txt   ${RESP.test_image_id}

Upload the image data
  # Is ${TEST_IMAGE_FILE} exist?
  Run Keyword If  os.path.exists("${TEST_IMAGE_FILE}") == False
  ...   Get the image file
  Move File     ${TEST_IMAGE_FILE}  ${GABBIT_PATH}/
  ${path}   ${img_file} =   Split Path  ${TEST_IMAGE_FILE}
  upload image data     url=${IMAGE_SERVICE}
  ...                   IMAGE_FILE=${img_file}

Get the image file
  ${rc} =   Run And Return Rc
  ...           curl -sLo ${TEST_IMAGE_FILE} ${TEST_IMAGE_URL}
  Should Be Equal As Integers   ${rc}   0

Check if the created image is in image list and active
  created image is in image list and active    url=${IMAGE_SERVICE}

Update the image name
  # create application/openstack-images-v2.1-json-patch file
  Create File   ${GABBIT_PATH}/update_image.json   [{"op":"replace","path":"/name","value":"${TEST_IMAGE_NAME}-new" }]
  update image name     url=${IMAGE_SERVICE}

Delete the image
  delete image      url=${IMAGE_SERVICE}

The image is gone
  image is gone     url=${IMAGE_SERVICE}


