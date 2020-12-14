*** Variables ***

#
# Service Endpoints
#
${IDENTITY_SERVICE}     http://keystone.openstack.svc.cluster.local:8080/v3
${NETWORK_SERVICE}      http://neutron.openstack.svc.cluster.local:8080/v2.0
${IMAGE_SERVICE}        http://glance.openstack.svc.cluster.local:8080/v2
${VOLUME_SERVICE}       http://cinder.openstack.svc.cluster.local:8080/v3
${COMPUTE_SERVICE}      http://nova.openstack.svc.cluster.local:8080/v2.1

#
# adminrc
#
${USER_NAME}            admin
${USER_PASSWORD}        password
${DOMAIN_NAME}          default
${PROJECT_NAME}         admin

# network test
# PUBLIC_NETWORK_ID: openstack external network ID - used by floating ip test.
# Create it with 'openstack network create' command before running the test.
#${PUBLIC_NETWORK_ID}   <external network ID>
${PUBLIC_NETWORK_ID}    6e2abf30-6093-4b6a-9db4-f5e70f629975

# volume test
# admin project id used by volume test. Put admin project id here.
${PROJECT_ID}               00bce98645894a8c9bee220b1a249a7b
# Define volume backend name
${VOLUME_BACKEND_NAME}      rbd1

# compute test
# Define compute host list
@{COMPUTE_HOSTS}            taco2-comp1     taco2-comp2


##########################################
# Do not touch below!!!                  #
##########################################

#
# identity test
#
${TEST_PROJECT_NAME}    sparring
${TEST_PROJECT_DESC}    Sparring Test Project
${TEST_USER_NAME}       sparring-user
${TEST_USER_PASSWORD}   password

#
# network test
#
${TEST_NETWORK_NAME}    sparring-network
${TEST_SUBNET_NAME}     sparring-subnet
${TEST_SUBNET_CIDR}     172.24.1.0/24
${TEST_ROUTER_NAME}     sparring-router
${TEST_PORT_NAME}       sparring-port
${TEST_NETWORK_QUOTA}   10

#
# image test
# 
# We use cirros image. 
# Try to download it from the internet if ${TEST_IMAGE_FILE} is not found.
# If there is no internet, put the image ${TEST_IMAGE_FILE} manually.
${TEST_IMAGE_NAME}                  sparring-image
${TEST_IMAGE_CONTAINER_FORMAT}      bare
${TEST_IMAGE_DISK_FORMAT}           qcow2
# Go to https://download.cirros-cloud.net/ and get the url of image file.
${TEST_IMAGE_URL}                   https://download.cirros-cloud.net/0.5.1/cirros-0.5.1-x86_64-disk.img
${TEST_IMAGE_FILE}                  /tmp/cirros.img

#
# volume test
#
${TEST_VOLUME_TYPE_NAME}    sparring-volume-type
${TEST_VOLUME_NAME}         sparring-volume
${TEST_VOLUME_SIZE}         1
${TEST_VOLUME_RESIZE}       2
${TEST_SNAPSHOT_NAME}       sparring-snapshot

#
# compute test
#
${TEST_FLAVOR_NAME}         sparring-flavor
${TEST_FLAVOR_VCPUS}        1
${TEST_FLAVOR_RAM}          1024
${TEST_FLAVOR_DISK}         10
${TEST_QUOTA_CORES}         10
${TEST_AGGREGATE_NAME}      sparring-aggregate
${TEST_SERVER_NAME}         sparring-server
${TEST_SERVER_DESC}         Test Sparring Server
${TEST_FLAVOR2_NAME}        sparring-flavor2
${TEST_FLAVOR2_VCPUS}       2
${TEST_FLAVOR2_RAM}         2048
${TEST_FLAVOR2_DISK}        10
${TEST_IMAGE_FROM_SERVER}   sparring-image-from-server
