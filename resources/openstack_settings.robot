*** Variables ***

# Service Endpoint
${COMPUTE_SERVICE}      http://nova.openstack.svc.cluster.local:8080/v2.1
${IDENTITY_SERVICE}     http://keystone.openstack.svc.cluster.local:8080/v3
${NETWORK_SERVICE}      http://neutron.openstack.svc.cluster.local:8080/v2.0
${VOLUME_SERVICE}       http://cinder.openstack.svc.cluster.local:8080/v3
${IMAGE_SERVICE}        http://glance.openstack.svc.cluster.local:8080/v2

# adminrc
${USER_NAME}            admin
${USER_PASSWORD}        password
${DOMAIN_NAME}          default
${PROJECT_NAME}         admin

# identity test
${TEST_PROJECT_NAME}    sparring
${TEST_PROJECT_DESC}    Sparring Test Project

# network test
${TEST_NETWORK_NAME}    sparring-network
${TEST_SUBNET_NAME}     sparring-subnet
${TEST_SUBNET_CIDR}     172.24.1.0/24
${TEST_ROUTER_NAME}     sparring-router
${TEST_PORT_NAME}       sparring-port
