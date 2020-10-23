Sparring
=========

Sparring is a test robot for OpenStack platform.

Install
---------

python3 virtual environment: Create a python3 virtual environment and
install robotframework, gabbi, and robotframework-gabbilibrary.::

   $ sudo apt update && sudo apt install -y python3-venv
   $ mkdir ~/.envs
   $ python3 -m venv ~/.envs/sparring
   $ source ~/.envs/sparring/bin/activate
   (sparring) $ python -m pip install wheel
   (sparring) $ python -m pip install gabbi robotframework
   (sparring) $ cd robotframework-gabbilibrary
   (sparring) $ python setup.py bdist_wheel
   (sparring) $ python -m pip install \
      dist/robotframework_gabbilibrary-0.1.1-py3-none-any.whl

Settings
----------

Edit .bashrc to include python virtualenv and sparring bin path.::

   $ vi $HOME/.bashrc
   ...
   source $HOME/.envs/sparring/bin/activate
   PATH=${HOME}/sparring/bin:$PATH
   
   $ source $HOME/.bashrc

Run
----

There are two robots in Sparring.

* funcbot: functional/scenario testing robot
* perfbot: performance testing robot

Use sparring command to run them.

List test suites in funcbot::

   $ sparring --list-funcbot
   identity
   network
   image
   volume
   compute

To run all test suites in funcbot::

   $ sparring --funcbot 

To run identity and network test suites in funcbot::

   $ sparring --funcbot identity network


