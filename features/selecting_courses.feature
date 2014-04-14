Feature: Selecting Classes

  Scenario: Successful selection
    Given I visit the courses page
    When I select a course
      And I have the required prerequisite 
    Then the course should disappear 
      And I should see the course posted 

  Scenario: Unsuccessful selection
    Given I visit the courses page
    When I select a course
      And I dont have the required prerequisite 
    Then I should see an error message