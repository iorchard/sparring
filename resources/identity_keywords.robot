*** Keywords ***
# common
Identity service is available
  connect to identity service   IDENTITY_SERVICE=${IDENTITY_SERVICE}

User gets auth token
  &{RESP} =     get auth token  url=${IDENTITY_SERVICE}
  ...                        USER_NAME=${USER_NAME}  DOMAIN_NAME=${DOMAIN_NAME}
  ...                        USER_PASSWORD=${USER_PASSWORD}
  ...                        PROJECT_NAME=${PROJECT_NAME}
  Set Environment Variable  SERVICE_TOKEN   ${RESP.auth_token}

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

Show the project info
  show project info         url=${IDENTITY_SERVICE}

Rename the project
  rename project            url=${IDENTITY_SERVICE}
  ...                       TEST_PROJECT_NEWNAME=${TEST_PROJECT_NAME}-new

Delete the project
  delete project            url=${IDENTITY_SERVICE}

The project is gone
  project is gone           url=${IDENTITY_SERVICE}

Clean the project
  clean project             url=${IDENTITY_SERVICE}
