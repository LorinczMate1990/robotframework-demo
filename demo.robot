*** Settings ***
Resource    robotTestLibrary.robot

Library    String
Library    ./Pylabry.py    first library instance    WITH NAME    pylabry1
Library    ./Pylabry.py    second library instance    WITH NAME    pylabry2

Suite Setup    This keyword should run in the beginning of the testing
Suite Teardown    This test case should run after every tests is finished

Test Setup    This keyword shold run before every testcases
Test Teardown    This keyword shold run after every testcases

*** Variables ***
${foo}=   5
*** Test Cases ***
Test case 1
    Log To Console    This is the message of the test case 1

Test case 2
    Log To Console    This is the message of the test case 2
    [Setup]    NONE
    pylabry1.this is a keyword
    [Teardown]    NONE

Test case 3
    Log To Console    This is the message of the test case 3
    Keyword with some data as inline variable
    Keyword with regular parameters    param1    param 2    param3
    ${retVal}=    Keyword with return
    Log To Console    RetVal: ${retVal}

Test case to demonstrate templates 1
    [Template]    Keyword for template demo wit ${a} and ${doesntReallyMetter}
    val1OfParam1    val1ForParam2
    foo    bar
    small    big

Test case to demonstrate templates 2
    [Template]    Keyword with regular parameters
    val1OfParam1    val1ForParam2   1
    foo    bar   2
    small    big   3

# Before Robot 4 there was no traditional conditional branches, but we can use keywords for the same effect
# The following test cases will demonstrate these keywords

Finish case conditionaly
    Log To Console    "This message appears"
    ${var}=    Set Variable    555
    Pass Execution    '${var}' == '555'    Optional message
    Log To Console    "This message will never appear"

Assign variable conditionaly
    ${var}=    Set Variable    555
    ${var2}=    Set Variable    666
    Log To Console    Value of var: ${var}, value of var2: ${var2}
    ${var2}=    Set Variable If    ${var} == 556    111    
    Log To Console    Value of var2: ${var2}
    ${var2}=    Set Variable If    '${var}' == '556'    111    2222
    Log To Console    Value of var2: ${var2}

Basic demo with lists
    @{list}=    Create List    1    2    3
    Log to console    The list as \${list} (scalar variable): ${list}
    Log to console    The list as \@{list} (list variable): @{list}
    Log to console    Calling keyword with ${list}
    Keyword with regular parameters    ${list}    Secund param    Third param
    Log to console    Calling keyword with @{list}
    Keyword with regular parameters    @{list}
    
    ${length of dollar list}=    Get Length    ${list}

    Log To Console    Get Length \${list}: ${length of dollar list}
    Log To Console    Get Length \@{list}: <This would cause errors because 'Get length \@{list}' would call Get Length with 3 parameters

    Log To Console    Split list to three params
    ${a}    ${b}    ${c} =    Set Variable    ${list}
    Log To Console    \${a}: ${a}, \${b}: ${b}, \${c}: ${c}

Difference between \$ and \@ at assignminet
    ${dummy}    @{variable using \@ at assign} =    Create List    1    2    3
    ${dummy}    ${variable using \$ at assign} =    Create List    1    2

    Log To Console    variable using \@ at assign: ${variable using \@ at assign}
    Log To Console    variable using \$ at assign: ${variable using \$ at assign}

    Log To Console    Could we use a list variable in the middle of the left side of an assignment? Yes.

    ${dummy}    @{listVariable}    ${dummy2} =    Create List    1    2    3   4

    Log To Console    dummy: ${dummy}, listVariable: ${listVariable}, dummy2: ${dummy2}

Basic demo with dictionaries
    # https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Create%20Dictionary
    Log To Console    TODO

*** Keywords ***
This keyword should run in the beginning of the testing
    Log To Console    CALL This keyword should run in the beginning of the testing

This test case should run after every tests is finished
    Log To Console    CALL This test case should run after every tests is finished

This keyword shold run before every testcases
    Log To Console    CALL This keyword shold run before every testcases

This keyword shold run after every testcases
    Log To Console    CALL This keyword shold run after every testcases

Keyword with ${text} as inline variable
    Log To Console    Variable: ${text}

Keyword for template demo wit ${param1} and ${param2}
    Log To Console    This keyword was called with '${param1}' and '${param2}'

Keyword with regular parameters
    [Arguments]    ${par1}    ${par2}    ${par3}
    Log To Console    Parameters: '${par1}', '${par2}', '${par3}'

Keyword with return
    [Return]    This is a return value