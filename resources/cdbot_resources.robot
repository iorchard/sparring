*** Settings ***
Library             SSHLibrary
Library             Process

*** Variables ***
${PROBE}            ${EXECDIR}/../bin/probe.sh
${TOLERABLE}        2

*** Keywords ***
Log into ssh host
  SSHLibrary.Open Connection    ${SSH_HOST}     port=${SSH_PORT}
  ...                           timeout=3s      alias=ssh-conn
  SSHLibrary.Login      ${SSH_USER}     ${SSH_PASS}

Check if service is available
  [Arguments]   ${name}
  ${rc}     ${retcode} =  Run And Return Rc And Output
  ...   curl -s -w \%{http_code} -o /dev/null -m 2 ${${name}_svc.url}
  Should Be Equal As Integers   ${rc}   0
  Should Be Equal As Integers   ${retcode}   ${${name}_svc.retcode}

Check if there is an image for update
  [Arguments]   ${name}
  # Get an image source of ${name}
  ${img} =      SSHLibrary.Execute Command
  ...   kubectl get deploy ${${name}_svc.name} -n openstack -o=jsonpath='{.spec.template.spec.containers[0].image}'
  Set Suite Variable    ${${name}_svc.image}    ${img}
  Log   \n${img}      console=True
  # Append '-u1' to the image and push the tagged image
  ${rc} =       SSHLibrary.Execute Command
  ...   sudo docker tag ${img} ${img}-u1   return_stdout=False  return_rc=True
  Should Be Equal As Integers   ${rc}   0
  ${rc} =       SSHLibrary.Execute Command
  ...   sudo docker push ${img}-u1   return_stdout=False    return_rc=True
  Should Be Equal As Integers   ${rc}   0

Check prerequisites
  [Arguments]   ${name}
  Check if service is available     ${name}
  Check if there is an image for update     ${name}

Test rolling update
  [Arguments]   ${name}
  Log   \n  console=True
  ${handle} =   Start sending requests to api service every second    ${name}
  Set Suite Variable    ${handle}
  Rolling update the service    ${name}
  Check if rolling update is done    ${name}
  Stop sending requests
  Check if the service failure is tolerable     ${name}

Start sending requests to api service every second
  [Arguments]   ${name}
  Log   Start sending requests to ${name} api service every second  console=True
  ${handle} =   Start Process
  ...   ${PROBE} ${${name}_svc.url} ${${name}_svc.retcode} /tmp/${name}.log
  ...   shell=True
  ${pid} =  Get Process Id  ${handle}
  Log   ${PROBE} pid is ${pid} from ${handle}   console=True
  [Return]  ${handle}

Rolling update the service
  [Arguments]   ${name}
  Log   Rolling update the ${name} service  console=True
  ${rc} =   SSHLibrary.Execute Command
  ...   kubectl --record deployment.apps/${${name}_svc.name} set image deployment.v1.apps/${${name}_svc.name} ${${name}_svc.cname}=${${name}_svc.image}-u1 -n openstack
  ...   return_stdout=False     return_rc=True
  Should be Equal As Integers   ${rc}   0
  
Check if rolling update is done
  [Arguments]   ${name}
  Wait Until Keyword Succeeds   2 min    10 sec     Is update done  ${name}

Is update done
  [Arguments]   ${name}
  ${rc} =   SSHLibrary.Execute Command
  ...   kubectl rollout status deployment.v1.apps/${${name}_svc.name} -n openstack
  ...   return_stdout=False     return_rc=True
  Log   Check if rolling update is done: ${rc}  console=True
  Should be Equal As Integers   ${rc}   0
  
Stop sending requests
  Sleep     10s
  Log   Stop sending requests...    console=True
  Run Keyword And Ignore Error  
  ...   Send Signal To Process    SIGTERM     ${handle}   group=True

Check if the service failure is tolerable
  [Arguments]   ${name}
  ${fail} =  Run    grep -c FAIL /tmp/${name}.log
  ${pass} =  Run    grep -c PASS /tmp/${name}.log
  ${all} =   Run    wc -l /tmp/${name}.log|cut -d' ' -f1
  Log   Total requests: ${all}, Pass: ${pass}, Fail: ${fail}    console=True
  Run Keyword If    ${fail} > ${TOLERABLE}   Fail
  ...   There are ${fail} failures greater than the limit (${TOLERABLE}).

