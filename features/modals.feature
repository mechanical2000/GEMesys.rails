@javascript
Feature: Modals
  Background:
    When I go on the "modals" test page

  Scenario: no data modal link
    Then I see "current page id is 0" out of modal
    When I click on "no data modal link"
    Then I see "current page id is 1" out of modal
    When I click on "no data modal link"
    Then I see "current page id is 2" out of modal

  Scenario: normal modal link + no data modal link
    Then I see "current page id is 0" out of modal
    When I click on "normal modal link"
    Then I see "current page id is 1" in modal
    When I click on "no data modal link"
    Then I see "current page id is 2" out of modal

  Scenario: nested modal link + no data modal link
    Then I see "current page id is 0" out of modal
    When I click on "nested modal link"
    Then I see "current page id is 1" in modal
    When I click on "no data modal link"
    Then I see "current page id is 2" in modal
    When I click on "no data modal link"
    Then I see "current page id is 3" in modal

  Scenario: nested modal link + off modal link
    Then I see "current page id is 0" out of modal
    When I click on "nested modal link"
    Then I see "current page id is 1" in modal
    When I click on "off modal link"
    Then I see "current page id is 2" out of modal

  Scenario: normal modal link + no data modal form
    Then I see "current page id is 0" out of modal
    When I click on "normal modal link"
    Then I see "current page id is 1" in modal
    When I click on "no data modal form"
    Then I see "current page id is 2" out of modal
    Then I see "request method is POST" out of modal

  Scenario: nested modal link + no data modal form
    Then I see "current page id is 0" out of modal
    When I click on "nested modal link"
    Then I see "current page id is 1" in modal
    When I click on "no data modal form"
    Then I see "current page id is 2" in modal
    Then I see "request method is POST" in modal
    When I click on "no data modal form"
    Then I see "current page id is 3" in modal
    Then I see "request method is POST" in modal

  Scenario: nested modal link + off modal form
    Then I see "current page id is 0" out of modal
    When I click on "nested modal link"
    Then I see "current page id is 1" in modal
    When I click on "off modal form"
    Then I see "current page id is 2" out of modal
    Then I see "request method is POST" out of modal

  Scenario: nested modal link + mailto link
    Then I see "current page id is 0" out of modal
    When I click on "nested modal link"
    Then I see "current page id is 1" in modal
    When I click on "mailto link"
    Then I do not see "current page id is 2"
    Then I see "current page id is 1" in modal

  Scenario: nested modal link + tel link
    Then I see "current page id is 0" out of modal
    When I click on "nested modal link"
    Then I see "current page id is 1" in modal
    When I click on "tel link"
    Then I do not see "current page id is 2"
    Then I see "current page id is 1" in modal

  Scenario: nested modal link + sms link
    Then I see "current page id is 0" out of modal
    When I click on "nested modal link"
    Then I see "current page id is 1" in modal
    When I click on "sms link"
    Then I do not see "current page id is 2"
    Then I see "current page id is 1" in modal

  Scenario: nested modal link + javascript link
    Then I see "current page id is 0" out of modal
    When I click on "nested modal link"
    Then I see "current page id is 1" in modal
    When I click on "javascript link"
    Then I do not see "current page id is 2"
    Then I see "current page id is 1" in modal

  Scenario: nested modal link + data remote link
    Then I see "current page id is 0" out of modal
    When I click on "nested modal link"
    Then I see "current page id is 1" in modal
    When I click on "data remote link"
    Then I do not see "current page id is 2"
    Then I see "current page id is 1" in modal

  Scenario: nested modal link + target blank link
    Then I see "current page id is 0" out of modal
    When I click on "nested modal link"
    Then I see "current page id is 1" in modal
    When I click on "target blank link"
    Then I do not see "current page id is 2"
    Then I see "current page id is 1" in modal

  Scenario: nested modal link + data method link
    Then I see "current page id is 0" out of modal
    When I click on "nested modal link"
    Then I see "current page id is 1" in modal
    When I click on "data method link"
    Then I see "current page id is 2" in modal
    Then I see "request method is POST" in modal

  Scenario: data method link without modal
    Then I see "current page id is 0" out of modal
    When I click on "data method link"
    Then I see "current page id is 1" out of modal
    Then I see "request method is POST" out of modal

  Scenario: normal modal link + data method link
    Then I see "current page id is 0" out of modal
    When I click on "normal modal link"
    Then I see "current page id is 1" in modal
    When I click on "data method link"
    Then I see "current page id is 2" out of modal
