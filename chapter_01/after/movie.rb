class Movie
  attr_reader :title

  def initialize(title, price_code)
    @title, @price = title, Object.const_get(price_code).new
  end

  def frequent_renter_points(days_rented)
    @price.frequent_renter_points(days_rented)
  end

  def charge(days_rented)
    @price.charge(days_rented)
  end
end

module DefaultPrice
  def frequent_renter_points(days_rented)
    1
  end
end

class RegularPrice
  include DefaultPrice
  def charge(days_rented)
    result = 2
    result += (days_rented - 2) * 1.5 if days_rented > 2
    result
  end
end

class NewReleasePrice
  def charge(days_rented)
    return days_rented * 3
  end

  def frequent_renter_points(days_rented)
    days_rented > 1 ? 2 : 1
  end
end

class ChildrensPrice
  include DefaultPrice
  def charge(days_rented)
    result = 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 3
    result
  end
end
