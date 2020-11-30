*** Keywords ***
Compute service is available
  connect to compute service  COMPUTE_SERVICE=${COMPUTE_SERVICE}

Clean the compute resources if test failed
  Run Keyword If Any Tests Failed   Clean compute resources
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

  Run Keyword And Ignore Error  remove host from aggregate
  ...                           url=${COMPUTE_SERVICE}
  ...                           TEST_AGGREGATE_ID=${test_aggregate_id}
  ...                           TEST_HYPERVISOR_HOST=${test_hypervisor_host}
  Run Keyword And Ignore Error  clean aggregate    url=${COMPUTE_SERVICE}
  ...                           TEST_AGGREGATE_ID=${test_aggregate_id}
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

