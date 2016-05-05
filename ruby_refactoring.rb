class Movie
  attr_reader :title

  def initialize(title)
    @title = title
  end

  def amount_for(days)
    this_amount = 2
    this_amount += (days - 2) * 1.5 if days > 2
    this_amount
  end

  def renter_points(days)
    1
  end

  def to_s
    "\t" + @title
  end
end

class ChildrenMovie < Movie
  def amount_for(days)
    this_amount = 1.5
    this_amount += (days - 3) * 1.5 if days > 3
    this_amount
  end
end

class NewReleaseMovie < Movie
  def amount_for(days)
    days * 3
  end

  def renter_points(days)
    renter_point = 1
    renter_point += 1 if days > 1
    renter_point
  end
end

class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end

  def amount
    @movie.amount_for @days_rented
  end

  def renter_points
    @movie.renter_points @days_rented
  end

  def to_s
    @movie.to_s + "\t" + amount.to_s + "\n"
  end
end


class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{@name}\n"

    @rentals.each do |rental|
      result += rental.to_s
      total_amount += rental.amount
      frequent_renter_points += rental.renter_points
    end

    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
  end
end