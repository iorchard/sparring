*** Keywords ***
# common
Network service is available
  connect to network service    NETWORK_SERVICE=${NETWORK_SERVICE}

Clean the network if test failed
  Run Keyword If Any Tests Failed   Clean network resources

Clean network resources
  # get info from txt file
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/floatingip.txt
  ${test_floatingip_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/floatingip.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/port.txt
  ${test_port_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/port.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/router.txt
  ${test_router_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/router.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/public_subnet.txt
  ${test_public_subnet_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/public_subnet.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/subnet.txt
  ${test_subnet_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/subnet.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/network.txt
  ${test_network_id} =  Run Keyword If     ${rc} == 0
  ...   Get File    ${TEMPDIR}/network.txt

  Run Keyword And Ignore Error  clean floating ip   url=${NETWORK_SERVICE}
  ...                           TEST_FLOATINGIP_ID=${test_floatingip_id}
  Run Keyword And Ignore Error  clean port      url=${NETWORK_SERVICE}
  ...                           TEST_PORT_ID=${test_port_id}
  Run Keyword And Ignore Error  clean router interface  url=${NETWORK_SERVICE}
  ...                           TEST_ROUTER_ID=${test_router_id}
  ...                           TEST_SUBNET_ID=${test_subnet_id}
  Run Keyword And Ignore Error  clean router    url=${NETWORK_SERVICE}
  ...                           TEST_ROUTER_ID=${test_router_id}
  Run Keyword And Ignore Error  clean subnet    url=${NETWORK_SERVICE}
  ...                           TEST_SUBNET_ID=${test_public_subnet_id}
  Run Keyword And Ignore Error  clean subnet    url=${NETWORK_SERVICE}
  ...                           TEST_SUBNET_ID=${test_subnet_id}
  Run Keyword And Ignore Error  clean network   url=${NETWORK_SERVICE}
  ...                           TEST_NETWORK_ID=${test_network_id}
  #Remove File       ${TEMPDIR}/*.txt 

# 
# network
#
Create a network
  &{RESP} =     create network      url=${NETWORK_SERVICE}
  ...                               TEST_NETWORK_NAME=${TEST_NETWORK_NAME}
  Set Environment Variable      TEST_NETWORK_ID  ${RESP.test_network_id}
  Create File    ${TEMPDIR}/network.txt   ${RESP.test_network_id}

Show the network info
  show network info         url=${NETWORK_SERVICE}

Check if the created network is in network list
  created network is in network list    url=${NETWORK_SERVICE}

Rename the network name
  rename network name   url=${NETWORK_SERVICE}
  ...                   TEST_NETWORK_NEWNAME=${TEST_NETWORK_NAME}-new

Create a subnet
  &{RESP} =     create subnet       url=${NETWORK_SERVICE}
  ...                               TEST_SUBNET_NAME=${TEST_SUBNET_NAME}
  ...                               TEST_SUBNET_CIDR=${TEST_SUBNET_CIDR}
  Set Environment Variable      TEST_SUBNET_ID  ${RESP.test_subnet_id}
  Create File    ${TEMPDIR}/subnet.txt   ${RESP.test_subnet_id}

Show the subnet info
  show subnet info         url=${NETWORK_SERVICE}

Check if the created subnet is in subnet list
  created subnet is in subnet list  url=${NETWORK_SERVICE}

Rename the subnet name
  rename subnet name    url=${NETWORK_SERVICE}
  ...                   TEST_SUBNET_NEWNAME=${TEST_SUBNET_NAME}-new

#
# router
#
Create a router
  &{RESP} =     create router       url=${NETWORK_SERVICE}
  ...                               TEST_ROUTER_NAME=${TEST_ROUTER_NAME}
  Set Environment Variable      TEST_ROUTER_ID  ${RESP.test_router_id}
  Create File    ${TEMPDIR}/router.txt   ${RESP.test_router_id}

Show the router info
  show router info         url=${NETWORK_SERVICE}

Check if the created router is in router list
  created router is in router list    url=${NETWORK_SERVICE}

Add an interface to the router
  &{RESP} =     add interface to router   url=${NETWORK_SERVICE}
  Set Environment Variable  TEST_ROUTER_PORT_ID  ${RESP.test_router_port_id}
  Create File    ${TEMPDIR}/router_port.txt   ${RESP.test_router_port_id}

Rename the router name
  rename router name    url=${NETWORK_SERVICE}
  ...                   TEST_ROUTER_NEWNAME=${TEST_ROUTER_NAME}-new

#
# port
#
Create a port
  &{RESP} =     create port     url=${NETWORK_SERVICE}
  ...                           TEST_PORT_NAME=${TEST_PORT_NAME}
  Set Environment Variable      TEST_PORT_ID  ${RESP.test_port_id}
  Create File    ${TEMPDIR}/port.txt   ${RESP.test_port_id}

Show the port info
  show port info         url=${NETWORK_SERVICE}

Check if the created port is in port list
  created port is in port list    url=${NETWORK_SERVICE}

Rename the port name
  rename port name      url=${NETWORK_SERVICE}
  ...                   TEST_PORT_NEWNAME=${TEST_PORT_NAME}-new

#
# floating ip
#
Create a floating ip
  &{RESP} =     create floating ip     url=${NETWORK_SERVICE}
  ...                           PUBLIC_NETWORK_ID=${PUBLIC_NETWORK_ID}
  Set Environment Variable      TEST_FLOATINGIP_ID  ${RESP.test_floatingip_id}
  Create File    ${TEMPDIR}/floatingip.txt   ${RESP.test_floatingip_id}

Show the floating ip info
  show floating ip info         url=${NETWORK_SERVICE}

Check if the created floating ip is in floating ip list
  created floating ip is in floating ip list    url=${NETWORK_SERVICE}

Update the floating ip description
  update floating ip description       url=${NETWORK_SERVICE}

#
# quota
#
Update the network quota
  update network quota      url=${NETWORK_SERVICE}
  ...                       TEST_NETWORK_QUOTA=${TEST_NETWORK_QUOTA}

Check if the network quota is set
  network quota is set      url=${NETWORK_SERVICE}
  ...                       TEST_NETWORK_QUOTA=${TEST_NETWORK_QUOTA}

