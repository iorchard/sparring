*** Keywords ***
Compute service is available
  connect to compute service  COMPUTE_SERVICE=${COMPUTE_SERVICE}

Clean the compute resources if test failed
  Run Keyword If Any Tests Failed   Clean compute resources

Clean compute resources
  # get info from txt file
  Log   Clean compute resources     console=True
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/flavor.txt
  ${test_flavor_id} =   Run Keyword If  ${rc} == 0
  ...                       Get File    ${TEMPDIR}/flavor.txt

  Run Keyword And Ignore Error  clean flavor    url=${COMPUTE_SERVICE}
  ...                           TEST_FLAVOR_ID=${test_flavor_id}

#
# hypervisor
#
List hypervisors
  &{RESP} =     list hypervisor   url=${COMPUTE_SERVICE}
  Set Environment Variable  TEST_HYPERVISOR_ID  ${RESP.test_hypervisor_id}

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

