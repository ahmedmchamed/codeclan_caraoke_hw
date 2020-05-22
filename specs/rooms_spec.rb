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
        @adult1 = Guest.new()
        @adult2 = Guest.new()
        @adult3 = Guest.new()

        #Testing for a family in a family room
        @parent_or_guardian1 = Guest.new()
        @parent_or_guardian2 = Guest.new()
        @child1 = Guest.new()
        @child2 = Guest.new()

        #Testing for a group of old dears in the geriatrics room
        @old_dear1 = Guest.new()
        @old_dear2 = Guest.new()
        @old_dear3 = Guest.new()

        #Defining the rooms and their names
        @regular_room = Rooms.new("Regular room", )
        @family_room = Rooms.new("Family room")
        @geriatrics_room = Rooms.new("Geriatrics room")
    end

end