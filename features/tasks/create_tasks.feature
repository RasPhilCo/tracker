@domain @api
Feature: Creating tasks for a project

  Rules:
  - Project ID is required
  - Name is required
  - Created projects should default to "todo" state


  Scenario: Creating a task with all fields
    Given a project:
      | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    When I create a task for a project with:
      | NAME        | My Important Task                     |
      | DESCRIPTION | This is a sample task.                |
      | STATE       | todo                                  |
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
    Then the project has the task:
      | NAME              | STATE  | PROJECT_ID                            |
      | My Important Task | todo   | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |


  Scenario: Creating a task that is marked in-progress
    Given a project:
      | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    When I create a task for a project with:
      | NAME        | My Important Task                     |
      | DESCRIPTION | This is a sample task.                |
      | STATE       | in-progress                           |
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
    Then the project has the task:
      | NAME              | STATE         | PROJECT_ID                            |
      | My Important Task | in-progress   | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |


  Scenario: Creating a task that is marked done
    Given a project:
      | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    When I create a task for a project with:
      | NAME        | My Important Task                     |
      | DESCRIPTION | This is a sample task.                |
      | STATE       | done                                  |
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
    Then the project has the task:
      | NAME              | STATE  | PROJECT_ID                            |
      | My Important Task | done   | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |


  Scenario: Trying to create a task without a valid project
    When I create a task for a project with:
      | DESCRIPTION | This is a sample task.  |
      | NAME        | My Important Task       |
      | STATE       | todo                    |
      | PROJECT_ID  | not-a-real-project-id   |
    Then the system has 0 tasks
    And I get the error "Project can't be blank or invalid"


  Scenario: Trying to create a task without a name
    Given a project:
      | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    When I create a task for a project with:
      | DESCRIPTION | This is a sample task.                |
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
      | STATE       | todo                                  |
    Then the system has 0 tasks
    And I get the error "Name can't be blank"
