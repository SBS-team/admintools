@javascript
Feature: Manage Users
  In order to manage user details
  As a security enthusiast
  I want to edit user profiles only when authorized


  Background: : Login Admin
    Given the following admin records exist:
      | name  | password |
      | admin | 123456   |
    When I go to on the admin login page
    And I am logged in as "admin" with password "123456"
    Then I should see "Signed in as admin"

  Scenario: Create User
    When I go to on Пользователи page
    Then I should see "Фото & Имя & Фамилия & Роль & Телефон & Email & Skype & Офис"
    And I click on the Создать button to user create
    And I should see "Добавить пользователя"

    And I create a new user with fields "makar, makarich, wq@wq.wq, wqwqw"
    When I go to on Пользователи page
    Then I should see "makar & makarich & wq@wq.wq & wqwqw"
    And I should see flash message "Пользователь makar makarich добавлен"

    When I go to on Офисы page
    Then I should see "id & Офис & Управляющий & Кол-во ПК & Создать"
    And I click on the Создать button to room create
    And I should see "Добавить офис"

    Given I create a new room "Ruby Office" and select user "makar makarich"
    When I go to on Офисы page
    Then I should see "1 & Ruby Office & makar makarich & 0 & Конструктор & Просмотр & Редактировать & Удалить"
    And I should see flash message "Офис Ruby Office добавлен"










