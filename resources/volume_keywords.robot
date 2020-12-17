*** Keywords ***
# common
Volume service is available
  connect to volume service    VOLUME_SERVICE=${VOLUME_SERVICE}

Clean the volume resources if test failed
  Run Keyword If Any Tests Failed   Clean volume resources
  Run Keyword If Any Tests Failed   Clean the project

Clean volume resources
  # get info from txt file
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/image_snapshot.txt
  ${test_image_snapshot_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/image_snapshot.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/snapshot.txt
  ${test_snapshot_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/snapshot.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/image_from_vol.txt
  ${test_image_id_from_vol} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/image_from_vol.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/image.txt
  ${test_image_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/image.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/volume.txt
  ${test_volume_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/volume.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/volume2.txt
  ${test_volume_id2} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/volume2.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/volume_type.txt
  ${test_volume_type_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/volume_type.txt

  # Get snapshot id of "snapshot for sparring-image-from-server" name
  ${status}     ${result} =     Run Keyword And Ignore Error    
  ...           Get a snapshot id of image from server  url=${VOLUME_SERVICE}
  ...               SNAPSHOT_NAME="snapshot for ${TEST_IMAGE_FROM_SERVER}"
  ...               PROJECT_ID=${PROJECT_ID}
  &{RESP} =     Run Keyword If  '${status}' == 'PASS'
  ...           Get a snapshot id of image from server  url=${VOLUME_SERVICE}
  ...               SNAPSHOT_NAME="snapshot for ${TEST_IMAGE_FROM_SERVER}"
  ...               PROJECT_ID=${PROJECT_ID}
  Run Keyword And Ignore Error  clean snapshot from image  url=${VOLUME_SERVICE}
  ...                           TEST_SNAPSHOT_ID=${RESP.snapshot_id}
  ...                           PROJECT_ID=${PROJECT_ID}

  User gets auth test project scoped token
  Run Keyword And Ignore Error  clean snapshot   url=${VOLUME_SERVICE}
  ...                           TEST_SNAPSHOT_ID=${test_image_snapshot_id}

  Run Keyword And Ignore Error  clean snapshot   url=${VOLUME_SERVICE}
  ...                           TEST_SNAPSHOT_ID=${test_snapshot_id}
  Wait Until Keyword Succeeds   30s   3s
  ...   check snapshot is gone     url=${VOLUME_SERVICE}

  Run Keyword And Ignore Error  clean image   url=${IMAGE_SERVICE}
  ...                           TEST_IMAGE_ID=${test_image_id_from_vol}
  Wait Until Keyword Succeeds   30s  3s
  ...   image is gone       url=${IMAGE_SERVICE}
  ...                       TEST_IMAGE_ID=${test_image_id_from_vol}

  # There will be a readonly image-TEST_IMAGE_ID volume when upload volume.
  # need to delete it manually.
  # Get readonly volume id from image-TEST_IMAGE_ID name.
  ${status}     ${result} =     Run Keyword And Ignore Error    
  ...           get volume id from volume name      url=${VOLUME_SERVICE}
  ...                           TEST_VOLUME_NAME=image-${test_image_id}
  &{RESP} =     Run Keyword If  '${status}' == 'PASS'
  ...           get volume id from volume name      url=${VOLUME_SERVICE}
  ...                           TEST_VOLUME_NAME=image-${test_image_id}
  Run Keyword And Ignore Error  clean volume   url=${VOLUME_SERVICE}
  ...                           TEST_VOLUME_ID=${RESP.volume_id}
  Wait Until Keyword Succeeds   30s  3s
  ...   check volume is gone    url=${VOLUME_SERVICE}
  ...                           TEST_VOLUME_ID=image-${test_image_id_from_vol}

  Run Keyword And Ignore Error  clean volume   url=${VOLUME_SERVICE}
  ...                           TEST_VOLUME_ID=${test_volume_id2}
  Run Keyword And Ignore Error  Wait Until Keyword Succeeds   30s  3s
  ...   check volume is gone    url=${VOLUME_SERVICE}
  ...                           TEST_VOLUME_ID=${test_volume_id2}
  Run Keyword And Ignore Error  clean volume   url=${VOLUME_SERVICE}
  ...                           TEST_VOLUME_ID=${test_volume_id}
  Run Keyword And Ignore Error  Wait Until Keyword Succeeds   30s  3s
  ...   check volume is gone    url=${VOLUME_SERVICE}
  ...                           TEST_VOLUME_ID=${test_volume_id}

  User gets auth token

  Run Keyword And Ignore Error  Wait Until Keyword Succeeds   30s   3s
  ...   clean volume type       url=${VOLUME_SERVICE}
  ...                           TEST_VOLUME_TYPE_ID=${test_volume_type_id}

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
# volume quota
#
Update volume quota for the project
  update volume quota   url=${VOLUME_SERVICE}
  ...                   PROJECT_ID=${PROJECT_ID}

Check if the volume quota is set
  check volume quota is set     url=${VOLUME_SERVICE}
  ...                           PROJECT_ID=${PROJECT_ID}

# 
# volume
#
Create a volume
  &{RESP} =     create volume from image     url=${VOLUME_SERVICE}
  ...               TEST_VOLUME_NAME=${TEST_VOLUME_NAME}
  ...               TEST_VOLUME_SIZE=${TEST_VOLUME_SIZE}
  Set Environment Variable   TEST_VOLUME_ID  ${RESP.test_volume_id}
  Create File    ${TEMPDIR}/volume.txt   ${RESP.test_volume_id}

Check if the volume is available
  Wait Until Keyword Succeeds   30s   3s
  ...   check volume is available   url=${VOLUME_SERVICE}

Show the volume info
  show volume info          url=${VOLUME_SERVICE}
  ...                       TEST_VOLUME_NAME=${TEST_VOLUME_NAME}

Check if the created volume is in volume list
  created volume is in volume list    url=${VOLUME_SERVICE}
  ...               TEST_VOLUME_NAME=${TEST_VOLUME_NAME}

Resize the volume
  resize volume     url=${VOLUME_SERVICE}
  ...               TEST_VOLUME_RESIZE=${TEST_VOLUME_RESIZE}

Check if the volume is resized
  Wait Until Keyword Succeeds   30s   3s
  ...   check volume is resized     url=${VOLUME_SERVICE}
  ...               TEST_VOLUME_RESIZE=${TEST_VOLUME_RESIZE}

Update the volume name
  update volume name    url=${VOLUME_SERVICE}
  ...               TEST_VOLUME_NAME_NEW=${TEST_VOLUME_NAME}-new

#
# snapshot
#
Create a snapshot
  &{RESP} =     create snapshot      url=${VOLUME_SERVICE}
  ...               TEST_SNAPSHOT_NAME=${TEST_SNAPSHOT_NAME}
  Set Environment Variable   TEST_SNAPSHOT_ID  ${RESP.test_snapshot_id}
  Create File    ${TEMPDIR}/snapshot.txt   ${RESP.test_snapshot_id}

Check if the snapshot is available
  Wait Until Keyword Succeeds   30s   3s
  ...   check snapshot is available     url=${VOLUME_SERVICE}

Show the snapshot info
  show snapshot info        url=${VOLUME_SERVICE}
  ...                       TEST_SNAPSHOT_NAME=${TEST_SNAPSHOT_NAME}

Check if the created snapshot is in snapshot list
  created snapshot is in snapshot list    url=${VOLUME_SERVICE}
  ...               TEST_SNAPSHOT_NAME=${TEST_SNAPSHOT_NAME}

Update the snapshot name
  update snapshot name    url=${VOLUME_SERVICE}
  ...               TEST_SNAPSHOT_NAME_NEW=${TEST_SNAPSHOT_NAME}-new

#
# volume action
#
Upload the volume to image service
  &{RESP} =     upload volume to image service    url=${VOLUME_SERVICE}
  ...                               IMAGE_NAME=${TEST_IMAGE_NAME}-from-vol
  Set Environment Variable      TEST_IMAGE_ID_FROM_VOL
  ...                           ${RESP.test_image_id_from_vol}
  Create File    ${TEMPDIR}/image_from_vol.txt   ${RESP.test_image_id_from_vol}

Check if the image from vol is active
  Wait Until Keyword Succeeds   30s   3s
  ...   check image is active       url=${IMAGE_SERVICE}
  ...                               TEST_IMAGE_ID=%{TEST_IMAGE_ID_FROM_VOL}

Show the image from vol info
  show image info       url=${IMAGE_SERVICE}
  ...                   TEST_IMAGE_ID=%{TEST_IMAGE_ID_FROM_VOL}
  ...                   TEST_IMAGE_NAME=${TEST_IMAGE_NAME}-from-vol

Revert the volume to snapshot
  revert volume to snapshot     url=${VOLUME_SERVICE}

# used by compute/05_server.robot
Create a volume to attach to the server
  # Change auth token to test project scoped token for volume creation
  User gets auth test project scoped token
  &{RESP} =     create volume     url=${VOLUME_SERVICE}
  ...               TEST_VOLUME_NAME=${TEST_VOLUME_NAME}-2
  ...               TEST_VOLUME_SIZE=${TEST_VOLUME_SIZE}
  Set Environment Variable   TEST_VOLUME_ID2  ${RESP.test_volume_id}
  Create File    ${TEMPDIR}/volume2.txt   ${RESP.test_volume_id}

