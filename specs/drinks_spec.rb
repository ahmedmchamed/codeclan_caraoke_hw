require('minitest/autorun')
require('minitest/reporters')
require_relative('../drinks')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestDrink < MiniTest::Test

    def setup()
        @drink = Drinks.new("The Kraken", 5)
    end

    def test_get_drink_name()
        assert_equal("The Kraken", @drink.name())
    end

    def test_get_drink_price()
        assert_equal(5, @drink.price())
    end

end