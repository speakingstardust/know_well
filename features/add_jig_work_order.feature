Feature: Creating a jig work order.
  Background:
    Given a user that is either an Admin or has the bookkeeper role.
    And a customer.
    And jigs that belong to the customer.
  Scenario: I can create a jig work order for a customer with jigs.
    When I visit the new work order page.
    And I complete the initial work order form, choosing the type of work order and a customer. 
    Then I am on the jig work order details page. 
    And I am able to set a pickup date and time.
    And I am able to add the expected number of jigs to the work order.
    And I submit the new work order. 
    Then I am on the work order index page.
    And the new work order is present on the work order index page. 
