require('minitest/autorun')
require('minitest/reporters')
require_relative('../bar_orders')
require_relative('../guests')
require_relative('../drinks')
require_relative('../food')
require_relative('../rooms')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestBarOrders < MiniTest::Test

    def setup()

        @regular_room = Rooms.new("Regular room", 20)
        @family_room = Rooms.new("Family room", 15)

        @guest1 = Guests.new("John", 26, 35, "", :regular_room)
        @guest2 = Guests.new("Aliza", 25, 37, "", :regular_room)

        @drink1 = Drinks.new("Citrus Splash", 8)
        @drink2 = Drinks.new("The Devil's Mocharita", 12)
        @snack1 = Food.new("Tasty crisps", 5)
        @snack2 = Food.new("Dark chocolate biscuits", 6)

        @bar_order = BarOrders.new()
    end

    def test_get_bar_tab_amount()
        assert_equal(0, @bar_order.total_tab())
    end

    def test_guest_buys_food_and_drink_and_tab_is_updated()
        #Deduct food/beverage from guest
        @guest1.deduct_fees_amount(@drink2.price())
        @guest1.deduct_fees_amount(@snack2.price())
        #Add deducted amounts to bar_tab
        @bar_order.add_purchased_item_cost_to_tab(@drink2.price())
        @bar_order.add_purchased_item_cost_to_tab(@snack2.price())

        assert_equal(17, @guest1.get_wallet_amount())
        assert_equal(18, @bar_order.total_tab())
    end

    def test_assign_room_to_bar_tab()
        room_name = @guest2.chosen_room()
        @bar_order.assign_room_name(room_name)
        assert_equal(:regular_room, @bar_order.room())
    end

end