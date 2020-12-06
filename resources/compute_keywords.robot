*** Keywords ***
Compute service is available
  connect to compute service  COMPUTE_SERVICE=${COMPUTE_SERVICE}

Clean the compute resources if test failed
  Run Keyword If Any Tests Failed   Clean compute resources
  Run Keyword If Any Tests Failed   Clean network resources
  Run Keyword If Any Tests Failed   Clean volume resources
  Run Keyword If Any Tests Failed   Clean image resources
  Run Keyword If Any Tests Failed   Clean the project

Clean compute resources
  # get info from txt file
  Log   Clean compute resources     console=True
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/hypervisor_host.txt
  ${test_hypervisor_host} =   Run Keyword If  ${rc} == 0
  ...                       Get File    ${TEMPDIR}/hypervisor_host.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/aggregate.txt
  ${test_aggregate_id} =   Run Keyword If  ${rc} == 0
  ...                       Get File    ${TEMPDIR}/aggregate.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/flavor.txt
  ${test_flavor_id} =   Run Keyword If  ${rc} == 0
  ...                       Get File    ${TEMPDIR}/flavor.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/server.txt
  ${test_server_id} =   Run Keyword If  ${rc} == 0
  ...                       Get File    ${TEMPDIR}/server.txt

  Run Keyword And Ignore Error  remove host from aggregate
  ...                           url=${COMPUTE_SERVICE}
  ...                           TEST_AGGREGATE_ID=${test_aggregate_id}
  ...                           TEST_HYPERVISOR_HOST=${test_hypervisor_host}
  Run Keyword And Ignore Error  clean aggregate    url=${COMPUTE_SERVICE}
  ...                           TEST_AGGREGATE_ID=${test_aggregate_id}
  Run Keyword And Ignore Error  clean server    url=${COMPUTE_SERVICE}
  ...                           TEST_SERVER_ID=${test_server_id}
  Run Keyword And Ignore Error  clean flavor    url=${COMPUTE_SERVICE}
  ...                           TEST_FLAVOR_ID=${test_flavor_id}

#
# hypervisor
#
List hypervisors
  &{RESP} =     list hypervisor   url=${COMPUTE_SERVICE}
  Set Environment Variable  TEST_HYPERVISOR_ID  ${RESP.test_hypervisor_id}
  Set Environment Variable  TEST_HYPERVISOR_HOST  ${RESP.test_hypervisor_host}
  Create File   ${TEMPDIR}/hypervisor_host.txt   ${RESP.test_hypervisor_host}

List hypervisors details
  list hypervisor detail    url=${COMPUTE_SERVICE}

Show details for a hypervisor
  show detail for hypervisor    url=${COMPUTE_SERVICE}

#
# flavor
#
Create a flavor
  &{RESP} =     create flavor   url=${COMPUTE_SERVICE}
  ...               TEST_FLAVOR_NAME=${TEST_FLAVOR_NAME}
  ...               TEST_FLAVOR_VCPUS=${TEST_FLAVOR_VCPUS}
  ...               TEST_FLAVOR_RAM=${TEST_FLAVOR_RAM}
  ...               TEST_FLAVOR_DISK=${TEST_FLAVOR_DISK}
  Set Environment Variable  TEST_FLAVOR_ID  ${RESP.test_flavor_id}
  Create File   ${TEMPDIR}/flavor.txt   ${RESP.test_flavor_id}

Check if the created flavor is in flavor list
  check flavor is in flavor list    url=${COMPUTE_SERVICE}
  ...               TEST_FLAVOR_NAME=${TEST_FLAVOR_NAME}

Show the flavor info
  show flavor info      url=${COMPUTE_SERVICE}
  ...               TEST_FLAVOR_NAME=${TEST_FLAVOR_NAME}
  ...               TEST_FLAVOR_VCPUS=${TEST_FLAVOR_VCPUS}
  ...               TEST_FLAVOR_RAM=${TEST_FLAVOR_RAM}
  ...               TEST_FLAVOR_DISK=${TEST_FLAVOR_DISK}

#
# quota
#
Update the quotas for a project
  update quota for project  url=${COMPUTE_SERVICE}
  ...                       TEST_QUOTA_CORES=${TEST_QUOTA_CORES}

Check if the quotas are updated
  check quota updated   url=${COMPUTE_SERVICE}

#
# aggregate
#
Create an aggregate
  &{RESP} =     create aggregate      url=${COMPUTE_SERVICE}
  ...                   TEST_AGGREGATE_NAME=${TEST_AGGREGATE_NAME}
  Set Environment Variable  TEST_AGGREGATE_ID  ${RESP.test_aggregate_id}
  ${test_aggregate_id} =    Convert To String   ${RESP.test_aggregate_id}
  Create File   ${TEMPDIR}/aggregate.txt   ${test_aggregate_id}

Check if the created aggregate is in aggregate list
  check aggregate is in aggregate list  url=${COMPUTE_SERVICE}

Add a host to the aggregate
  add host to aggregate     url=${COMPUTE_SERVICE}

Update the aggregate
  update aggregate          url=${COMPUTE_SERVICE}
  ...                       TEST_AGGREGATE_NEWNAME=${TEST_AGGREGATE_NAME}-new

Show the aggregate info
  show aggregate info       url=${COMPUTE_SERVICE}

Remove a host from the aggregate
  remove host from aggregate    url=${COMPUTE_SERVICE}

#
# server
#
Create a volume and a port for a server
  Create a volume type
  Set the volume backend of the volume type
  Check if the created volume type is in volume type list
  Add the volume type to test project
  Check if the test project has an access to the volume type

  # Change auth token to test project scoped token for volume creation
  User gets auth test project scoped token 
  Create an image
  Upload the image data
  Check if the created image is in image list and active
  Create a volume
  Check if the volume is available

  # Change auth token to the default.
  User gets auth token 
  # create a port
  Create a network
  Create a subnet
  Create a port

Create a server with a port and a volume
  &{RESP} =     create server with port and volume    url=${COMPUTE_SERVICE}
  ...                   TEST_SERVER_NAME=${TEST_SERVER_NAME}
  Set Environment Variable  TEST_SERVER_ID  ${RESP.test_server_id}
  Create File   ${TEMPDIR}/server.txt   ${RESP.test_server_id}

Check if the server is active
  Wait Until Keyword Succeeds   30s   3s
  ...   check server is active    url=${COMPUTE_SERVICE}

Check if the created server is in server list
  check server is in server list    url=${COMPUTE_SERVICE}
  ...                               TEST_SERVER_NAME=${TEST_SERVER_NAME}

List servers details
  list server detail    url=${COMPUTE_SERVICE}
  ...                   TEST_SERVER_NAME=${TEST_SERVER_NAME}

Update the server info
  update server info    url=${COMPUTE_SERVICE}
  ...                   TEST_SERVER_NEWNAME=${TEST_SERVER_NAME}-new

Show the server info
  show server info      url=${COMPUTE_SERVICE}
  ...                   TEST_SERVER_NAME=${TEST_SERVER_NAME}

Check if the server has the floating ip
  check server has floating ip      url=${COMPUTE_SERVICE}
  ...                   TEST_NETWORK_NAME=${TEST_NETWORK_NAME}

Attach the volume to the server
  # Change auth token to the default.
  User gets auth token 
  attach volume to server   url=${COMPUTE_SERVICE}

Check if the volume is attached to the server
  check volume is attached to server    url=${COMPUTE_SERVICE}

Check if the server has the volume
  check server has volume   url=${COMPUTE_SERVICE}
