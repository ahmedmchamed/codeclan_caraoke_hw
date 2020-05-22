require('minitest/autorun')
require('minitest/reporters')
require_relative('../food')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestFood < MiniTest::Test

    def setup()
        @food = Food.new("Nachos", 10)
    end

    def test_get_food_name()
        assert_equal("Nachos", @food.name())
    end

    def test_get_food_price()
        assert_equal(10, @food.price())
    end

end