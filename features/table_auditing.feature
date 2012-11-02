Feature: Table audit actions
  In order to track changes to tables we audit certain actions

  Scenario Outline: User stamping a table on row modification
    Given A <u> user from the database
    When <u> makes a change to the <t> table
    Then the updater_id column should have <u>'s id
    And the updated_at column should have changed

    Examples:
      | u  | t |
      | user2 | Permission |
      | user2 | Project |
      | user2 | Site |
      | user2 | AudioRecording |
      | user2 | AudioEvent |
      | user2 | Tag |
      | user2 | User |
      | user2 | AudioEventTag |
      | user2 | Authorization |
      | user2 | ProjectSite |

  Scenario Outline: User stamping a table on row creation
    Given A <u> user from the database
    When <u> inserts a row in the <t> table
    Then the creator_id column should have <u>'s id
    And the updater_id column should have <u>'s id
    And the updated_at column should approximately equal the current time
    And the created_at column should approximately equal the current time

    Examples:
      | u  | t |
      | user2 | Permission |
      | user2 | Project |
      | user2 | Site |
      | user2 | AudioRecording |
      | user2 | AudioEvent |
      | user2 | Tag |
      | user2 | User |
      | user2 | AudioEventTag |
      | user2 | Authorization |
      | user2 | ProjectSite |

  Scenario Outline: User stamping an archived record
    Given A <u> user from the database
    When <u> deletes a row from the <t> table
    Then the deleter_id column should have <u>'s id
    And the deleted_at column should have changed

  Examples:
    | u | t|
    | user2 | Permission |
    | user2 | Project |
    | user2 | Site |
    | user2 | AudioRecording |
    | user2 | AudioEvent |
    | user2 | Tag |


  Scenario Outline: User stamping an archived record
    Given A <u> user from the database
    When <u> deletes a row from the <t> table
    And <u> deletes that row again from the table
    Then the record should no longer exist

  Examples:
    | u | t|
    | user2 | Permission |
    | user2 | Project |
    | user2 | Site |
    | user2 | AudioRecording |
    | user2 | AudioEvent |
    | user2 | Tag |

  Scenario Outline: deleting a record
    Given A <u> user from the database
    When <u> deletes a row from the <t> table
    Then the record should no longer exist

  Examples:
    | u | t|
    | user2 | User |
    | user2 | AudioEventTag |
    | user2 | Authorization |
    | user2 | ProjectSite |