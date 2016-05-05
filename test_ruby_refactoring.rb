require_relative "ruby_refactoring"
require "test/unit"


class RefactoringTest < Test::Unit::TestCase

  MOVIE_REGULAR = Movie.new("Avengers")
  MOVIE_CHILDRENS = ChildrenMovie.new("Cars")
  MOVIE_NEW_RELEASE = NewReleaseMovie.new("Civil War")

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

  def test_rental_new_release
    @customer.add_rental Rental.new(MOVIE_NEW_RELEASE, 1)
    assert_equal @customer.statement, rented_statement("Alessio", "Civil War", 3, 1)
  end

  def test_rental_new_release_more_than_one_day
    @customer.add_rental Rental.new(MOVIE_NEW_RELEASE, 2)
    assert_equal @customer.statement, rented_statement("Alessio", "Civil War", 6, 2)
  end

  def test_rental_two_movies
    @customer.add_rental Rental.new(MOVIE_NEW_RELEASE, 2)
    @customer.add_rental Rental.new(MOVIE_REGULAR, 3)

    rentals = [{movie: "Civil War", amount: 6},
               {movie: "Avengers", amount: 3.5}]
    assert_equal @customer.statement, rented_statement("Alessio", rentals, 9.5, 3)
  end

  def test_rental_three_new_releases
    @customer.add_rental Rental.new(MOVIE_NEW_RELEASE, 1)
    @customer.add_rental Rental.new(MOVIE_NEW_RELEASE, 3)
    @customer.add_rental Rental.new(MOVIE_NEW_RELEASE, 8)

    rentals = [{movie: "Civil War", amount: 3},
               {movie: "Civil War", amount: 9},
               {movie: "Civil War", amount: 24}]
    assert_equal @customer.statement,  rented_statement("Alessio", rentals, 36, 5)
  end


  def rented_statement(customer, rentals, amount, frequent_renter_points)
    statement = "Rental Record for #{customer}\n"

    if rentals.is_a? String
      statement += "\t#{rentals}\t#{amount}\n"
    else
      rentals.each do |rental|
        statement += "\t#{rental[:movie]}\t#{rental[:amount]}\n"
      end
    end

    statement += "Amount owed is #{amount}\nYou earned #{frequent_renter_points} frequent renter points"
  end
end