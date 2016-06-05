@domain @api
Feature: Listing a task for a project

  Rules:
  - Project ID is required
  - Task ID is required


  Scenario: Verifying the format shape
    Given a project:
      | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
      | NAME        | Sample Project                        |
      | DESCRIPTION | A small sample project                |
      | STATE       | active                                |
    Given a task for a project:
      | ID          | 8c737315-62e4-4560-8d5f-aa706ed55cb8  |
      | NAME        | My Important Task                     |
      | DESCRIPTION | This is a sample task                 |
      | STATE       | todo                                  |
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
    When I request the task:
      | ID          | 8c737315-62e4-4560-8d5f-aa706ed55cb8  |
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
    Then I get the data:
      """
      {
        id: '8c737315-62e4-4560-8d5f-aa706ed55cb8',
        project_id: 'fce2bca3-14bc-49ed-9a15-01a38cc1d3a4',
        name: 'My Important Task',
        description: 'This is a sample task',
        state: 'todo'
      }
      """

    Scenario: Requesting a task with an invalid id
      Given a project:
        | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
        | NAME        | Sample Project                        |
        | DESCRIPTION | A small sample project                |
        | STATE       | active                                |
      Given a task for a project:
        | ID          | 8c737315-62e4-4560-8d5f-aa706ed55cb8  |
        | NAME        | My Important Task                     |
        | DESCRIPTION | This is a sample task                 |
        | STATE       | todo                                  |
        | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
      When I request the task:
        | ID          | not-an-actual-id                      |
        | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
      Then I get the error "Task not found"


    Scenario: Requesting a task with an invalid project id
      Given a project:
        | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
        | NAME        | Sample Project                        |
        | DESCRIPTION | A small sample project                |
        | STATE       | active                                |
      Given a task for a project:
        | ID          | 8c737315-62e4-4560-8d5f-aa706ed55cb8  |
        | NAME        | My Important Task                     |
        | DESCRIPTION | This is a sample task                 |
        | STATE       | todo                                  |
        | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
      When I request the task:
        | ID          | 8c737315-62e4-4560-8d5f-aa706ed55cb8  |
        | PROJECT_ID  | not-an-actual-id                      |
      Then I get the error "Task not found"
