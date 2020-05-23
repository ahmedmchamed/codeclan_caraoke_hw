require('minitest/autorun')
require('minitest/reporters')
require_relative('../rooms')
require_relative('../songs')
require_relative('../guests')
require_relative('../bar_orders')
require_relative('../admin')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestRooms < MiniTest::Test

    def setup()

        #Testing for a group of adult friends in a regular room
        @adult1_regular = Guests.new("Jessie", 28, 65, "Bohemian Rhapsody")
        @adult2_regular = Guests.new("Robert", 29, 50, "Introdiction")
        @adult3_regular = Guests.new("Alex", 31, 42, "Never Gonna Give You Up")

        #Testing for a family in a family room
        @parent_or_guardian1_family = Guests.new("Vicky", 45, 100, "Calum's Road")
        @parent_or_guardian2_family = Guests.new("Charles", 52, 90, "Smells Like Teen Spirit")
        @child1_family = Guests.new("Elsie", 8, 2, "Let It Go")
        @child2_family = Guests.new("Morven", 9, 2, "Mowana")

        #Testing for a group of old dears in the geriatrics room
        @old_dear1_geriatrics = Guests.new("Edith", 87, 60, "How Great Thou Art")
        @old_dear2_geriatrics = Guests.new("Gwyneth", 84, 65, "Summertime")
        @old_dear3_geriatrics = Guests.new("Eunice", 89, 75, "The Real Slim Shady")

        #Defining the rooms and their names
        @regular_room = Rooms.new("Regular room", 20)
        @family_room = Rooms.new("Family room", 10)
        @geriatrics_room = Rooms.new("Geriatrics room", 30)

    end

    def test_can_return_room_entry_fee()
        assert_equal(20, @regular_room.entry_fee())
    end

end