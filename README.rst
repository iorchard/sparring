Sparring
=========

Sparring is a API testing robot for OpenStack platform.

There are two ways to install and run a sparring robot - a container way or
a bare-metal way.

I recommend a container way since it's simpler.

Run a sparring container
--------------------------

Build (Optional)
++++++++++++++++++

You do not need to build a sparring image since it can be pulled from
docker hub (jijisa/sparring:latest).

But if you want to build a sparring image by yourself, run docker build.::

   $ docker build -t sparring .

Then use a local sparring image when you run a container.

Setup
+++++++++

Get the sample openstack_settings.robot file to /tmp/ and
Edit settings above "Do not touch below!!!" line.::

   $ docker run --rm --name sparring jijisa/sparring \
         --show-os-settings > /tmp/openstack_settings.robot

   $ vi /tmp/openstack-settings.robot
   #
   # Service Endpoints
   #
   ${IDENTITY_SERVICE}     https://keystone.openstack.svc.cluster.local:8443/v3
   ${NETWORK_SERVICE}      https://neutron.openstack.svc.cluster.local:8443/v2.0
   ${IMAGE_SERVICE}        https://glance.openstack.svc.cluster.local:8443/v2
   ${VOLUME_SERVICE}       https://cinder.openstack.svc.cluster.local:8443/v3
   ${COMPUTE_SERVICE}      https://nova.openstack.svc.cluster.local:8443/v2.1
   
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
   @{COMPUTE_HOSTS}            compute1     compute2


   ##########################################
   # Do not touch below!!!                  #
   ##########################################

Add endpoint hostnames in /etc/hosts file.::

   192.168.21.42 keystone.openstack.svc.cluster.local
   192.168.21.42 glance.openstack.svc.cluster.local
   192.168.21.42 nova.openstack.svc.cluster.local
   192.168.21.42 neutron.openstack.svc.cluster.local
   192.168.21.42 cinder.openstack.svc.cluster.local

Run
++++

There are three robots in Sparring.

* funcbot: functional/scenario testing robot
* cdbot: continuous delivery testing robot
* perfbot: performance testing robot (Not yet included! It will be included
  in the future.)

Use docker command to run them.

Show the help message.::

   $ docker run --rm --name sparring jijisa/sparring -h
   USAGE: /home/jijisa/sparring/bin/sparring {-h|-c|-d|-D|-s|-r|-l|-R|-L}
   
    -h --help                            Display this help message.
    -c --cleanup                         Clean up test resources.
    -d --run-cdbot [TEST_SUITE}...       Run Continuous Delivery test.
    -D --list-cdbot                      List cdbot test suites.
    -s --show-os-settings                Show openstack settings.
    -r --funcbot [TEST_SUITE]...         Run funcbot.
    -r --funcbot -e [TEST_SUITE]...      Run funcbot including evacuation test.
    -l --list-funcbot                    List funcbot test suites.
    -R --perfbot [TEST_SUITE]...         Run perfbot.
    -L --list-perfbot                    List perfbot test suites.

List test suites in funcbot::

   $ docker run --rm --name sparring jijisa/sparring --list-funcbot
   identity
   network
   image
   volume
   compute

To run all test suites in funcbot::

   $ docker run --rm --network=host \
      --name sparring \
      -v /etc/hosts:/etc/hosts:ro \
      -v /tmp/openstack_settings.robot:/sparring/resources/openstack_settings.robot:ro \
      -v /tmp/output:/tmp/output \
      jijisa/sparring | tee sparring.log

To run only identity and network test suites in funcbot::

   $ docker run --rm --network=host --name sparring \
      -v /etc/hosts:/etc/hosts:ro \
      -v /tmp/openstack_settings.robot:/sparring/resources/openstack_settings.robot:ro \
      -v /tmp/output:/tmp/output \
      jijisa/sparring --funcbot identity network | tee sparring.log

The result files (output.xml, log.html, report.html) will be in 
/tmp/output/ directory.

The console log file sparring.log will be in the current directory.

Install and Run on bare metal
-------------------------------

This is a guide to install and run sparring api robot on bare metal.

I assume Debian 10 (buster) is installed on bare metal.

Install
+++++++++

python3 virtual environment: Create a python3 virtual environment and
install robotframework, gabbi, and robotframework-gabbilibrary.::

   $ sudo apt update && sudo apt install -y python3-venv curl
   $ mkdir ~/.envs
   $ python3 -m venv ~/.envs/sparring
   $ source ~/.envs/sparring/bin/activate
   (sparring) $ python -m pip install wheel
   (sparring) $ python -m pip install gabbi robotframework
   (sparring) $ cd robotframework-gabbilibrary
   (sparring) $ python setup.py bdist_wheel
   (sparring) $ python -m pip install \
      dist/robotframework_gabbilibrary-0.1.1-py3-none-any.whl

Setup
++++++

Edit .bashrc to include python virtualenv and sparring bin path.::

   $ vi $HOME/.bashrc
   ...
   source $HOME/.envs/sparring/bin/activate
   PATH=${HOME}/sparring/bin:$PATH
   
   $ source $HOME/.bashrc

Edit ${HOME}/sparring/resources/openstack_settings.robot file 
above "Do not touch below!!!" line.::

   #
   # Service Endpoints
   #
   ${IDENTITY_SERVICE}     https://keystone.openstack.svc.cluster.local:8443/v3
   ${NETWORK_SERVICE}      https://neutron.openstack.svc.cluster.local:8443/v2.0
   ${IMAGE_SERVICE}        https://glance.openstack.svc.cluster.local:8443/v2
   ${VOLUME_SERVICE}       https://cinder.openstack.svc.cluster.local:8443/v3
   ${COMPUTE_SERVICE}      https://nova.openstack.svc.cluster.local:8443/v2.1
   
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
   @{COMPUTE_HOSTS}            compute1     compute2


   ##########################################
   # Do not touch below!!!                  #
   ##########################################

Add endpoint hostnames in /etc/hosts file.::

   192.168.21.42 keystone.openstack.svc.cluster.local
   192.168.21.42 glance.openstack.svc.cluster.local
   192.168.21.42 nova.openstack.svc.cluster.local
   192.168.21.42 neutron.openstack.svc.cluster.local
   192.168.21.42 cinder.openstack.svc.cluster.local

Run
++++

There are three robots in Sparring.

* funcbot: functional/scenario testing robot
* cdbot: continuous delivery testing robot
* perfbot: performance testing robot (Not yet included!)

Use sparring command to run them.

Show the help message.::

   $ sparring -h
   USAGE: /home/jijisa/sparring/bin/sparring {-h|-c|-d|-D|-s|-r|-l|-R|-L}
   
    -h --help                            Display this help message.
    -c --cleanup                         Clean up test resources.
    -d --run-cdbot [TEST_SUITE}...       Run Continuous Delivery test.
    -D --list-cdbot                      List cdbot test suites.
    -s --show-os-settings                Show openstack settings.
    -r --funcbot [TEST_SUITE]...         Run funcbot.
    -l --list-funcbot                    List funcbot test suites.
    -R --perfbot [TEST_SUITE]...         Run perfbot.
    -L --list-perfbot                    List perfbot test suites.

List test suites in funcbot::

   $ sparring --list-funcbot
   identity
   network
   image
   volume
   compute

To run all test suites in funcbot::

   $ sparring --funcbot | tee sparring.log

To run only identity and network test suites in funcbot::

   $ sparring --funcbot identity network | tee sparring.log

