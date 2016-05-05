require_relative "ruby_refactoring"
require "test/unit"


class RefactoringTest < Test::Unit::TestCase

  def test_basic_customer_creation
    customer = Customer.new "Alessio"
    assert_equal "Alessio", customer.name
  end

  def test_check_rental_regular_statement
    customer = Customer.new "Alessio"
    movie_regular = Movie.new("Avengers", Movie::REGULAR)
    customer.add_rental Rental.new movie_regular, 2
    assert_equal "Rental Record for Alessio\n\tAvengers\t2\nAmount owed is 2\nYou earned 1 frequent renter points", customer.statement
  end

  def test_rental_regular_more_than_two_days
    customer = Customer.new "Alessio"
    movie_regular = Movie.new("Avengers", Movie::REGULAR)
    customer.add_rental Rental.new movie_regular, 3
    assert_equal "Rental Record for Alessio\n\tAvengers\t3.5\nAmount owed is 3.5\nYou earned 1 frequent renter points", customer.statement
  end

end