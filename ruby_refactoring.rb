class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title
  attr_reader :price_code

  def initialize(title, price_code)
    @title, @price_code = title, price_code
  end

  def amount_for(days)
    this_amount = 0
    case @price_code
      when Movie::REGULAR
        this_amount += 2
        this_amount += (days - 2) * 1.5 if days > 2
      when Movie::NEW_RELEASE
        this_amount += days * 3
      when Movie::CHILDRENS
        this_amount += 1.5
        this_amount += (days - 3) * 1.5 if days > 3
    end
    this_amount
  end

  def renter_points(days)
    renter_point = 1
    renter_point += 1 if days > 1 && @price_code == Movie::NEW_RELEASE
    renter_point
  end

  def to_s
    "\t" + @title
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
    result
  end
end