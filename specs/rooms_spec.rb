require('minitest/autorun')
require('minitest/reporters')
require_relative('../rooms')
require_relative('../songs')
require_relative('../guests')
require_relative('../bar')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestRooms < MiniTest::Test

    def setup()

        #Testing for a group of adult friends in a regular room
        @adult1_regular = Guest.new("Jessie", 28, 65, "Bohemian Rhapsody")
        @adult2_regular = Guest.new("Robert", 29, 50, "Introdiction")
        @adult3_regular = Guest.new("Alex", 31, 42, "Never Gonna Give You Up")

        #Testing for a family in a family room
        @parent_or_guardian1_family = Guest.new("Vicky", 45, 100, "Calum's Road")
        @parent_or_guardian2_family = Guest.new("Charles", 52, 90, "Smells Like Teen Spirit")
        @child1_family = Guest.new("Elsie", 8, 2, "Let It Go")
        @child2_family = Guest.new("Morven", 9, 2, "Mowana")

        #Testing for a group of old dears in the geriatrics room
        @old_dear1_geriatrics = Guest.new("Edith", 87, 60, "How Great Thou Art")
        @old_dear2_geriatrics = Guest.new("Gwyneth", 84, 65, "Summertime")
        @old_dear3_geriatrics = Guest.new("Eunice", 89, 75, "The Real Slim Shady")

        #Defining the rooms and their names
        @regular_room = Rooms.new("Regular room", )
        @family_room = Rooms.new("Family room")
        @geriatrics_room = Rooms.new("Geriatrics room")

        
    end

end