require_relative '../customer'
require_relative '../movie'
require_relative '../rental'

describe 'Movie Rental' do
  context 'prints out customer statement' do
    movie_1 = Movie.new('Captain Marvel', Movie::NEW_RELEASE)
    movie_2 = Movie.new('Wreck it Ralph', Movie::CHILDRENS)
    movie_3 = Movie.new('Star Wars Episode X', Movie::REGULAR)

    customer = Customer.new('Adam')

    it 'for new release' do
      customer.add_rental(Rental.new(movie_1, 2))

      expect(customer.statement).to eq <<~END.strip
        Rental Record for Adam
        	Captain Marvel	6
        Amount owed is 6
        You earned 2 frequent renter points
      END

      expect(customer.html_statement).to eq <<~END.strip
        <h1>Rentals for <em>Adam</em></h1><p>
        	Captain Marvel: 6<br>
        <p>You owe <em>6</em></p>
        On this rental you earned <em>2</em> frequent renter points</p>
      END
    end

    it 'for childrens' do
      customer.add_rental(Rental.new(movie_2, 3))

      expect(customer.statement).to eq <<~END.strip
        Rental Record for Adam
        	Captain Marvel	6
        	Wreck it Ralph	1.5
        Amount owed is 7.5
        You earned 3 frequent renter points
      END

      expect(customer.html_statement).to eq <<~END.strip
        <h1>Rentals for <em>Adam</em></h1><p>
        	Captain Marvel: 6<br>
        	Wreck it Ralph: 1.5<br>
        <p>You owe <em>7.5</em></p>
        On this rental you earned <em>3</em> frequent renter points</p>
      END
    end

    it 'for regular' do
      customer.add_rental(Rental.new(movie_3, 10))

      expect(customer.statement).to eq <<~END.strip
        Rental Record for Adam
        	Captain Marvel	6
        	Wreck it Ralph	1.5
        	Star Wars Episode X	14.0
        Amount owed is 21.5
        You earned 4 frequent renter points
      END

      expect(customer.html_statement).to eq <<~END.strip
        <h1>Rentals for <em>Adam</em></h1><p>
        	Captain Marvel: 6<br>
        	Wreck it Ralph: 1.5<br>
        	Star Wars Episode X: 14.0<br>
        <p>You owe <em>21.5</em></p>
        On this rental you earned <em>4</em> frequent renter points</p>
      END
    end
  end
end
