@focus
Feature: Manage Users
  In order to manage user details
  As a security enthusiast
  I want to edit user profiles only when authorized

  Scenario: Show administrators link
    Given the following admin records exist:
      | name  | password |
      | admin | 123456   |
    When I go to on the admin login page
    And I am logged in as "admin" with password "123456"
    Then I should see "Signed in as admin"
    When I go to on Пользователи page
    Then I should see "Создать"

    And the following user records exist:
      | first_name  | last_name | email    | skype |
      | makar       |  makarich | wq@wq.wq | wqwqw |
    When I click on the Создать button
    Then I should see "Добавить пользователя"

    And I create a new user with fields "first_name, last_name, email, skype"
    When I go to on Пользователи page
    Then I should see "makar"
    And I should see "makarich"
    And I should see "wq@wq.wq"
    And I should see "wqwqw"







