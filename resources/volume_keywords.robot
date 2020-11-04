*** Keywords ***
# common
Volume service is available
  connect to volume service    VOLUME_SERVICE=${VOLUME_SERVICE}

Clean the volume resources if test failed
  Run Keyword If Any Tests Failed   Clean volume resources
  Run Keyword If Any Tests Failed   Clean the project

Clean volume resources
  # get info from txt file
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/volume_type.txt
  ${test_volume_type_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/volume_type.txt

  Run Keyword And Ignore Error  clean volume type   url=${VOLUME_SERVICE}
  ...                           TEST_VOLUME_TYPE_ID=${test_volume_type_id}
  #Remove File       ${TEMPDIR}/*.txt 

# 
# volume type
#
Create a volume type
  &{RESP} =     create volume type      url=${VOLUME_SERVICE}
  ...               TEST_VOLUME_TYPE_NAME=${TEST_VOLUME_TYPE_NAME}
  ...               PROJECT_ID=${PROJECT_ID}
  Set Environment Variable   TEST_VOLUME_TYPE_ID  ${RESP.test_volume_type_id}
  Create File    ${TEMPDIR}/volume_type.txt   ${RESP.test_volume_type_id}

Set the volume backend of the volume type
  set volume backend of volume type     url=${VOLUME_SERVICE}
  ...               VOLUME_BACKEND_NAME=${VOLUME_BACKEND_NAME}
  ...               PROJECT_ID=${PROJECT_ID}

Show the volume type info
  show volume type info         url=${VOLUME_SERVICE}
  ...               VOLUME_BACKEND_NAME=${VOLUME_BACKEND_NAME}
  ...               PROJECT_ID=${PROJECT_ID}

Check if the created volume type is in volume type list
  created volume type is in volume type list    url=${VOLUME_SERVICE}
  ...               TEST_VOLUME_TYPE_NAME=${TEST_VOLUME_TYPE_NAME}
  ...               PROJECT_ID=${PROJECT_ID}

Add the volume type to test project
  add volume type to test project   url=${VOLUME_SERVICE}
  ...               PROJECT_ID=${PROJECT_ID}

Check if the test project has an access to the volume type
  test project has access to volume type     url=${VOLUME_SERVICE}
  ...               PROJECT_ID=${PROJECT_ID}

