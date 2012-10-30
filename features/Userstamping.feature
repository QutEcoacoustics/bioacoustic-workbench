Feature: User stamping
  In order to track changes to tables, a user stamp should be applied when changed

  Scenario Outline: User stamping a table
    Given A <u> user from the database
    When <u> makes a change to the <t> table
    Then Then the updater_id column should have <u>'s id

    Examples:
      | u  | t |
      | tester | Project |
      | tester | Site |


  Scenario Outline: User stamping a table
    Given A <u> user from the database
    When <u> inserts a row in the <t> table
    Then Then the creator_id column should have <u>'s id
    And Then the updater_id column should have <u>'s id

    Examples:
      | u  | t |
      | tester | Project |
      | tester | Project |
