require('minitest/autorun')
require('minitest/reporters')
require_relative('../bar_orders')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestBarOrders < MiniTest::Test

    def setup()
        @bar_order = BarOrders.new(100)
    end

    def test_get_bar_tab_amount()
        assert_equal(100, @bar_order.total_tab())
    end

end