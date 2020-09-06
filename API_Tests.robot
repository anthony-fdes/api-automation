*** Settings ***
Library  RequestsLibrary
Library  Collections


*** Variables ***
${base_url}     https://jsonplaceholder.typicode.com
${employee_id}  1
${query_key}    website
${query_value}  kale.biz

*** Test Cases ***
Perform_GET_Path_Parameter
    [Documentation]     Testing first documentation
    [Tags]      timepass
    create session     getsession    ${base_url}     verify=True
    ${response}=    get request     getsession   /users/${employee_id}

    #VALIDATING THE API RESPONSES
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200

    ${response_header}=     get from dictionary     ${response.headers}    Content-Type
    should be equal      ${response_header}      application/json; charset=utf-8

    ${response_body}=   convert to string       ${response.content}
    should contain      ${response_body}        Leanne Graham


Perform_GET_Query_Parameter
    create session      querysession       ${base_url}      verify=True
    ${response}=        get request         querysession        /users?${query_key}=${query_value}

    #VALIDATING THE API RESPONSES
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200

    ${response_header}=     get from dictionary     ${response.headers}    Content-Type
    should be equal      ${response_header}      application/json; charset=utf-8

    ${response_body}=   convert to string       ${response.content}
    should contain      ${response_body}        Karianne


Make_POST_Request
    create session      mysession       ${base_url}     verify=True
    ${data}=    create dictionary       id=11   name=Anthony Fernandes
    ${headers}=     create dictionary   Content-Type=application/json; charset=utf-8
    ${response}=    post request        mysession       /users      data=${data}    headers=${headers}

    #VALIDATION OF RESPONSES
    ${response_status}=     convert to string   ${response.status_code}
    should be equal     ${response_status}      201

    ${response_name}=    convert to string   ${response.content}
    should contain      ${response_name}    Anthony Fernandes

    ${response_header}=      get from dictionary     ${response.headers}    Content-Type
    should be equal         ${response_header}       application/json; charset=utf-8


Make_PUT_Request
    create session      putsession      ${base_url}     verify=True
    ${data}=    create dictionary       name=Tony Starks
    ${headers}=     create dictionary   Contet-Type=application/json; charset=utf-8
    ${response}=    put request     putsession   /users/2    data=${data}    headers=${headers}

    #VALIDATION OF RESPONSES
    ${response_status}=     convert to string   ${response.status_code}
    should be equal     ${response_status}      200

    ${response_name}=    convert to string   ${response.content}
    should contain      ${response_name}    2   Tony Stark


Make_DELETE_Request
    create session      delsession      ${base_url}     verify=True
    ${response}=    delete request      delsession      /users/6

    #VALIDATION OF RESPONSES
    ${response_status}=     convert to string       ${response.status_code}
    should be equal         ${response_status}      200

    ${response_content}=    convert to string       ${response.content}
    length should be       ${response_content}      2


Make_PATCH_Request
    [Tags]      timepass
    create session      patchsession      ${base_url}     verify=True
    ${data}=    create dictionary       name=Endurance International
    ${headers}=     create dictionary   Contet-Type=application/json; charset=utf-8
    ${response}=    patch request     patchsession   /users/4    data=${data}    headers=${headers}

    #VALIDATION OF RESPONSES
    ${response_status}=     convert to string   ${response.status_code}
    should be equal     ${response_status}      200

    ${response_name}=    convert to string   ${response.content}
    should contain      ${response_name}    4

