require('minitest/autorun')
require('minitest/reporters')
require_relative('../admin')
require_relative('../guests')
require_relative('../rooms')
require_relative('../songs')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestAdmin < MiniTest::Test

    def setup()
        #Testing for guests who are in a regular room
        @guest1_regular = Guests.new("Tom", 32, 45, "Without Me")
        @guest2_regular = Guests.new("Samantha", 34, 50, "Eye of the Tiger")
        @guest3_regular = Guests.new("Rick", 36, 55, "Don't Stop Me Now")
        
        #Organising engaged room guests into an array
        @guests_engaged = [@guest1_regular, @guest2_regular, @guest3_regular]

        #Songs for the regular room playlist
        @song1_regular = Songs.new("Hit Me With Your Rhythm Stick", "Ian Dury And The Blockheads", 180, false)
        @song2_regular = Songs.new("Common People", "Pulp", 240, false)
        @song3_regular = Songs.new("The Beautiful People", "Marilyn Manson", 210, true)

        @regular_room_playlist = [@song1_regular, @song2_regular, @song3_regular]

        #Testing for guests who are waiting for occupied room
        #to be free
        @guest4_waiting = Guests.new("Pete", 28, 67, "Hallelujah")
        @guest5_waiting = Guests.new("Bob", 29, 40, "Nightcall")
        @guest6_Waiting = Guests.new("Zack", 25, 56, "The Girl And The Robot")

        #Organising waiting guests into an array
        @guests_waiting = [@guest4_waiting, @guest5_waiting, @guest6_waiting]

        @song1_waiting = Songs.new("9th Symphony", "Beethoven", 3000, false)

        @waiting_room_playlist = [@song1_waiting]

        #Declaring the rooms
        @regular_room = Rooms.new("Regular Room", @guests_engaged, @regular_room_playlist, 20)
        @waiting_room = Rooms.new("Waiting Room", @guests_waiting, @waiting_room_playlist, 0)

        #Defining the hash of occupied rooms for the day
        @engaged_rooms_status = {
            regular_room: @guests_engaged,
            waiting_room: @guests_waiting
        }

        #Defining the admin's login session for the day
        @admin_login = Admin.new(@engaged_rooms_status)
    end

    

end