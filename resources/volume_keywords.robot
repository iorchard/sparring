*** Keywords ***
# common
Volume service is available
  connect to volume service    VOLUME_SERVICE=${VOLUME_SERVICE}

Clean the volume resources if test failed
  Run Keyword If Any Tests Failed   Clean volume resources
  Run Keyword If Any Tests Failed   Clean the project

Clean volume resources
  # get info from txt file
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/volume.txt
  ${test_volume_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/volume.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/volume_type.txt
  ${test_volume_type_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/volume_type.txt

  User gets auth test project scoped token
  Run Keyword And Ignore Error  clean volume   url=${VOLUME_SERVICE}
  ...                           TEST_VOLUME_ID=${test_volume_id}
  User gets auth token
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

# 
# volume
#
Create a volume
  &{RESP} =     create volume      url=${VOLUME_SERVICE}
  ...               PROJECT_ID=${PROJECT_ID}
  ...               TEST_VOLUME_NAME=${TEST_VOLUME_NAME}
  ...               TEST_VOLUME_SIZE=${TEST_VOLUME_SIZE}
  ...               VOLUME_BACKEND_NAME=${VOLUME_BACKEND_NAME}
  Set Environment Variable   TEST_VOLUME_ID  ${RESP.test_volume_id}
  Create File    ${TEMPDIR}/volume.txt   ${RESP.test_volume_id}

Check if the volume is available
  Wait Until Keyword Succeeds   1 min   1s
  ...   check volume is available   url=${VOLUME_SERVICE}
  ...                               PROJECT_ID=${PROJECT_ID}

Show the volume info
  show volume info          url=${VOLUME_SERVICE}
  ...                       PROJECT_ID=${PROJECT_ID}
  ...                       TEST_VOLUME_NAME=${TEST_VOLUME_NAME}

Check if the created volume is in volume list
  created volume is in volume list    url=${VOLUME_SERVICE}
  ...               PROJECT_ID=${PROJECT_ID}
  ...               TEST_VOLUME_NAME=${TEST_VOLUME_NAME}

Resize the volume
  resize volume     url=${VOLUME_SERVICE}
  ...               PROJECT_ID=${PROJECT_ID}
  ...               TEST_VOLUME_RESIZE=${TEST_VOLUME_RESIZE}

Check if the volume is resized
  Wait Until Keyword Succeeds   1 min   1s
  ...   check volume is resized     url=${VOLUME_SERVICE}
  ...               PROJECT_ID=${PROJECT_ID}
  ...               TEST_VOLUME_RESIZE=${TEST_VOLUME_RESIZE}

Update the volume name
  update volume name    url=${VOLUME_SERVICE}
  ...               PROJECT_ID=${PROJECT_ID}
  ...               TEST_VOLUME_NAME_NEW=${TEST_VOLUME_NAME}-new

#
# volume quota
#
Update volume quota for the project
  update volume quota   url=${VOLUME_SERVICE}
  ...                   PROJECT_ID=${PROJECT_ID}

Check if the volume quota is set
  check volume quota is set     url=${VOLUME_SERVICE}
  ...                           PROJECT_ID=${PROJECT_ID}

