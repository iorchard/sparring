*** Keywords ***
# common
Identity service is available
  connect to identity service   IDENTITY_SERVICE=${IDENTITY_SERVICE}

User gets auth token
  &{RESP} =     get auth token  url=${IDENTITY_SERVICE}
  ...                       USER_NAME=${USER_NAME}
  ...                       DOMAIN_NAME=${DOMAIN_NAME}
  ...                       USER_PASSWORD=${USER_PASSWORD}
  ...                       PROJECT_NAME=${PROJECT_NAME}
  Set Environment Variable  SERVICE_TOKEN   ${RESP.auth_token}

User gets auth test project scoped token
  &{RESP} =     get auth test project scoped token  url=${IDENTITY_SERVICE}
  ...                       USER_NAME=${USER_NAME}
  ...                       DOMAIN_NAME=${DOMAIN_NAME}
  ...                       USER_PASSWORD=${USER_PASSWORD}
  ...                       TEST_PROJECT_NAME=${TEST_PROJECT_NAME}
  Set Environment Variable  SERVICE_TOKEN   ${RESP.auth_token}

Clean the project if test failed
  Run Keyword If Any Tests Failed   Clean project resources

Clean project resources
  # get info from txt file
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/user.txt
  ${test_project_id} =  Run Keyword If  ${rc} == 0
  ...   Get File    ${TEMPDIR}/user.txt
  ${rc} =   Run And Return Rc   ls ${TEMPDIR}/project.txt
  ${test_project_id} =  Run Keyword If  ${rc} == 0
  ...   Get File    ${TEMPDIR}/project.txt

  Run Keyword And Ignore Error  clean user      url=${IDENTITY_SERVICE}
  Run Keyword And Ignore Error  clean project   url=${IDENTITY_SERVICE}
  #Remove File      ${TEMPDIR}/project.txt

# domain
List all domains
  &{RESP} =     list domains    url=${IDENTITY_SERVICE}
  Set Environment Variable  DOMAIN_ID   ${RESP.domain_id}

Get the domain info
  get domain info   url=${IDENTITY_SERVICE}

# project
List all projects
  list projects     url=${IDENTITY_SERVICE}

Create a project
  &{RESP} =     create project    url=${IDENTITY_SERVICE}
  ...                               TEST_PROJECT_NAME=${TEST_PROJECT_NAME}
  ...                               TEST_PROJECT_DESC=${TEST_PROJECT_DESC}
  Set Environment Variable      TEST_PROJECT_ID  ${RESP.test_project_id}
  Create File   ${TEMPDIR}/project.txt  ${RESP.test_project_id}

Show the project info
  show project info         url=${IDENTITY_SERVICE}

Rename the project
  rename project            url=${IDENTITY_SERVICE}
  ...                       TEST_PROJECT_NEWNAME=${TEST_PROJECT_NAME}-new

#
# user
#
Create a user
  &{RESP} =     create user     url=${IDENTITY_SERVICE}
  ...                           TEST_USER_NAME=${TEST_USER_NAME}
  ...                           TEST_USER_PASSWORD=${TEST_USER_PASSWORD}
  Set Environment Variable      TEST_USER_ID  ${RESP.test_user_id}
  Create File   ${TEMPDIR}/user.txt  ${RESP.test_user_id}

Show the user info
  show user info         url=${IDENTITY_SERVICE}


#
# role
#
Assign the admin role to admin user on project
  &{RESP} =     get admin user id     url=${IDENTITY_SERVICE}
  Set Environment Variable      ADMIN_USER_ID  ${RESP.admin_user_id}
  &{RESP} =     get admin role id     url=${IDENTITY_SERVICE}
  Set Environment Variable      ADMIN_ROLE_ID  ${RESP.admin_role_id}
  
  assign admin role to admin user on project  url=${IDENTITY_SERVICE}

Assign the admin role to user on project
  &{RESP} =     get admin role id     url=${IDENTITY_SERVICE}
  Set Environment Variable      ADMIN_ROLE_ID  ${RESP.admin_role_id}
  
  assign admin role to user on project  url=${IDENTITY_SERVICE}

Check if user has the admin role on project
  check user has admin role on project  url=${IDENTITY_SERVICE}

# clean resources
Delete the project
  delete project            url=${IDENTITY_SERVICE}

The project is gone
  project is gone           url=${IDENTITY_SERVICE}

Clean the project
  clean project             url=${IDENTITY_SERVICE}
