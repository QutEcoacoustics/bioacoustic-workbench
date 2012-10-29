Feature: Try Cucumber
  In order to do better testing we are going to attempt to run cucumber tests

  Scenario:  Add two numbers together
    Given I have entered input 6 into a sum
    And I have entered input 8 into a sum
    When I evaluate the sum expression
    Then the result should be 14