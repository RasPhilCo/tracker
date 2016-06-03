@domain @api
Feature: Listing tasks for a project

  Rules:
  - if a negative page is requested, an error is thrown
  - if a page that is too high is requested, the last page is returned
  - if a negative page_size is requested, the default size is used


  Scenario: No parameters are specified and there are 26 tasks
    Given a project:
      | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    Given 26 tasks for a project:
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
    When I request the nested tasks list for the project with id:
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
    Then I get 25 tasks back
    And the current page is 1
    And the total pages is 2
    And the total results is 26


  Scenario: Specifying parameters for the last page
    Given a project:
      | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    Given 3 tasks for a project:
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
    When I request the nested tasks list for the project with parameters:
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | PAGE_SIZE   | 2                                    |
      | PAGE        | 2                                    |
    Then I get 1 task back
    And the current page is 2
    And the total pages is 2
    And the total results is 3


  Scenario: The specified page is outside of the acceptable range
    Given a project:
      | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    Given 3 tasks for a project:
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
    When I request the nested tasks list for the project with parameters:
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | PAGE_SIZE   | 2                                    |
      | PAGE        | 5                                    |
    Then I get 1 task back
    And the current page is 2
    And the total pages is 2
    And the total results is 3


  Scenario: The specified page size is greater than the number of tasks
    Given a project:
      | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    Given 2 tasks for a project:
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
    When I request the nested tasks list for the project with parameters:
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | PAGE_SIZE   | 10                                   |
      | PAGE        | 1                                    |
    Then I get 2 tasks back
    And the current page is 1
    And the total pages is 1
    And the total results is 2


  Scenario: The specified page is negative
    Given a project:
      | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    Given 2 tasks for a project:
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
    When I request the nested tasks list for the project with parameters:
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | PAGE        | -1                                   |
    Then I get the error "Page cannot be <= 0"

  Scenario: Verifying the format shape
    Given a project:
      | ID          | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
      | NAME        | Sample Project                       |
      | DESCRIPTION | A small sample project               |
      | STATE       | active                               |
    Given a task for a project:
      | ID          | 8c737315-62e4-4560-8d5f-aa706ed55cb8  |
      | NAME        | My Important Task                     |
      | DESCRIPTION | This is a sample task                 |
      | STATE       | todo                                  |
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4  |
    When I request the nested tasks list for the project with id:
      | PROJECT_ID  | fce2bca3-14bc-49ed-9a15-01a38cc1d3a4 |
    Then I get the data:
      """
      {
        tasks: [
          {
            id: '8c737315-62e4-4560-8d5f-aa706ed55cb8',
            project_id: 'fce2bca3-14bc-49ed-9a15-01a38cc1d3a4',
            name: 'My Important Task',
            description: 'This is a sample task',
            state: 'todo'
          }
        ],
        count: 1,
        current_page_number: 1,
        total_page_count: 1
      }
      """
