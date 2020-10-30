*** Variables ***

#
# Service Endpoint
#
${COMPUTE_SERVICE}      http://nova.openstack.svc.cluster.local:8080/v2.1
${IDENTITY_SERVICE}     http://keystone.openstack.svc.cluster.local:8080/v3
${NETWORK_SERVICE}      http://neutron.openstack.svc.cluster.local:8080/v2.0
${VOLUME_SERVICE}       http://cinder.openstack.svc.cluster.local:8080/v3
${IMAGE_SERVICE}        http://glance.openstack.svc.cluster.local:8080/v2

#
# adminrc
#
${USER_NAME}            admin
${USER_PASSWORD}        password
${DOMAIN_NAME}          default
${PROJECT_NAME}         admin

#
# identity test
#
# Do not touch below!
${TEST_PROJECT_NAME}    sparring
${TEST_PROJECT_DESC}    Sparring Test Project

#
# network test
#

# PUBLIC_NETWORK_ID: openstack external network ID - used by floating ip test.
# Create it with 'openstack network create' command before running the test.
#${PUBLIC_NETWORK_ID}   <external network ID>
${PUBLIC_NETWORK_ID}    6e2abf30-6093-4b6a-9db4-f5e70f629975

# Do not touch below!
${TEST_NETWORK_NAME}    sparring-network
${TEST_SUBNET_NAME}     sparring-subnet
${TEST_SUBNET_CIDR}     172.24.1.0/24
${TEST_ROUTER_NAME}     sparring-router
${TEST_PORT_NAME}       sparring-port
${TEST_NETWORK_QUOTA}   10

