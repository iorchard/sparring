*** Settings ***
Suite Setup     User gets auth token
Suite Teardown  Clean the compute resources if test failed

Resource        ${EXECDIR}/../resources/common_resources.robot
Resource        ${EXECDIR}/../resources/openstack_settings.robot
Resource        ${EXECDIR}/../resources/identity_keywords.robot
Resource        ${EXECDIR}/../resources/image_keywords.robot
Resource        ${EXECDIR}/../resources/network_keywords.robot
Resource        ${EXECDIR}/../resources/volume_keywords.robot
Resource        ${EXECDIR}/../resources/compute_keywords.robot

Library         GabbiLibrary    ${COMPUTE_SERVICE}     ${GABBIT_PATH}

*** Test Cases ***
Reboot the server
  [Tags]    compute     critical
  Given Compute service is available
  When Reboot the server
  Then Check if the server is active

Stop the server
  [Tags]    compute     critical
  Given Compute service is available
  When Stop the server
  Then Check if the server is stopped

Start the server
  [Tags]    compute     critical
  Given Compute service is available
  When Start the server
  Then Check if the server is active

Pause the server
  [Tags]    compute     critical
  Given Compute service is available
  When Pause the server
  Then Check if the server is paused

Unpause the server
  [Tags]    compute     critical
  Given Compute service is available
  When Unpause the server
  Then Check if the server is active

Resize the server to the new flavor
  [Tags]    compute     critical
  Given Compute service is available
  and Create a new flavor
  When Resize the server to the new flavor
  Then Check if the server is in verify resize

Confirm a resize action for the server
  [Tags]    compute     critical
  Given Compute service is available
  When Confirm a resize action for the server
  Then Check if the server is active

Delete the old flavor
  [Tags]    compute     critical
  Given Compute service is available
  When Delete the old flavor
  Then Check if the old flavor is gone

Rebuild the server
  [Tags]    compute     critical
  Given Compute service is available
  When Rebuild the server
  Then Check if the server is active

Stop the server for cold migration
  [Tags]    compute     critical
  Given Compute service is available
  When Stop the server
  Then Check if the server is stopped

Cold-migrate the server
  [Tags]    compute     critical
  Given Compute service is available
  and Check where the server is in
  When Migrate the server
  Then Check if the server is in verify resize
  and Confirm a resize action for the server

Check if the server is cold-migrated 
  [Tags]    compute     critical
  Given Compute service is available
  When Check if the server is stopped
  Then Check if the server is migrated

Start the server after cold migration
  [Tags]    compute     critical
  Given Compute service is available
  When Start the server
  Then Check if the server is active

Live-Migrate the server
  [Tags]    compute     critical
  Given Compute service is available
  and Check where the server is in
  When Live-Migrate the server
  Then Check if the server is migrating

Check if the server is migrating
  [Tags]    compute     critical
  Given Compute service is available
  When Check if the server is migrating

Abort live-migration of the server
  [Tags]    compute     critical
  Given Compute service is available
  When Abort live-migration of the server
  Then Check if the live-migraion is aborted

Live-Migrate the server again
  [Tags]    compute     critical
  Given Compute service is available
  and Check where the server is in
  When Live-Migrate the server

Check if the server is migrated
  [Tags]    compute     critical
  Given Compute service is available
  When Check if the server is migrating in detail
  Then Check if the server is active 
  and Check if the server is migrated

Evacuate the server
  [Tags]    compute     critical
  Given Compute service is available
  and Stop the server
  and Check if the server is stopped
  and Set forced_down flag for the service
  When Evacuate the server
  Then Check if the server is evacuated
  and Reset forced_down flag for the service
