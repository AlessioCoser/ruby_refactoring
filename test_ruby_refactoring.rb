require_relative "ruby_refactoring"
require "test/unit"


class RefactoringTest < Test::Unit::TestCase

  MOVIE_REGULAR = Movie.new("Avengers", Movie::REGULAR)
  MOVIE_CHILDRENS = Movie.new("Cars", Movie::CHILDRENS)
  MOVIE_NEW_RELEASE = Movie.new("Civil War", Movie::NEW_RELEASE)

  def setup
    @customer = Customer.new "Alessio"
  end

  def test_basic_customer_creation
    assert_equal "Alessio", @customer.name
  end

  def test_rental_regular_statement
    @customer.add_rental Rental.new(MOVIE_REGULAR, 2)
    assert_equal @customer.statement, rented_statement("Alessio", "Avengers", 2, 1)
  end

  def test_rental_regular_more_than_two_days
    @customer.add_rental Rental.new(MOVIE_REGULAR, 3)
    assert_equal @customer.statement, rented_statement("Alessio", "Avengers", 3.5, 1)
  end

  def test_children
    @customer.add_rental Rental.new(MOVIE_CHILDRENS, 2)
    assert_equal @customer.statement, rented_statement("Alessio", "Cars", 1.5, 1)
  end

  def test_children_more_than_three_days
    @customer.add_rental Rental.new(MOVIE_CHILDRENS, 4)
    assert_equal @customer.statement, rented_statement("Alessio", "Cars", 3.0, 1)
  end

  def test_rental_children_eight_days
    @customer.add_rental Rental.new(MOVIE_CHILDRENS, 8)
    assert_equal @customer.statement, rented_statement("Alessio", "Cars", 9.0, 1)
  end

  def test_rental_new_release_statement
    @customer.add_rental Rental.new(MOVIE_NEW_RELEASE, 2)
    assert_equal @customer.statement, rented_statement("Alessio", "Civil War", 6, 2)
  end

  def test_rental_new_release_five_days
    @customer.add_rental Rental.new(MOVIE_NEW_RELEASE, 5)
    assert_equal @customer.statement, rented_statement("Alessio", "Civil War", 15, 2)
  end

  def test_rental_two_movies
    @customer.add_rental Rental.new(MOVIE_NEW_RELEASE, 2)
    @customer.add_rental Rental.new(MOVIE_REGULAR, 3)
    assert_equal @customer.statement, "Rental Record for Alessio\n\tCivil War\t6\n\tAvengers\t3.5\nAmount owed is 9.5\nYou earned 3 frequent renter points"
  end


  def rented_statement(customer, movie, amount, frequent_renter_points)
    "Rental Record for #{customer}\n\t#{movie}\t#{amount}\nAmount owed is #{amount}\nYou earned #{frequent_renter_points} frequent renter points"
  end
end