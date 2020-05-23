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
        @guest1 = Guests.new("Tom", 32, 45, "Without Me", :regular_room)
        @guest2 = Guests.new("Samantha", 34, 50, "Eye of the Tiger", :regular_room)
        @guest3 = Guests.new("Rick", 36, 55, "Don't Stop Me Now", :regular_room)

        #Testing for guests who want the same group, but room
        #is occupied
        @guest4 = Guests.new("Pete", 28, 67, "Hallelujah", :regular_room)
        @guest5 = Guests.new("Bob", 29, 40, "Nightcall", :regular_room)
        @guest6 = Guests.new("Zack", 25, 56, "The Girl And The Robot", :regular_room)

        #Songs for the regular room playlist
        @song1 = Songs.new("Hit Me With Your Rhythm Stick", "Ian Dury And The Blockheads", 180, false)
        @song2 = Songs.new("Common People", "Pulp", 240, false)
        @song3 = Songs.new("The Beautiful People", "Marilyn Manson", 210, true)
        @song4 = Songs.new("9th Symphony", "Beethoven", 3000, false)
        @song5 = Songs.new("Minority", "Green Day", 170, true)

        @all_songs = [@song1, @song2, @song3, @song4, @song5]

        #Declaring the rooms with just their names
        #and entry fees
        @regular_room = Rooms.new(:regular_room, 20)
        @family_room = Rooms.new(:family_room, 15)
        @geriatrics_room = Rooms.new(:geriatrics_room, 10)
        @waiting_room = Rooms.new(:waiting_room, 0)

        #Defining the hash of occupied rooms for the day
        @engaged_rooms_status = {
            @regular_room => nil,
            @family_room => nil,
            @geriatrics_room => nil,
            @waiting_room => nil
        }

        #Defining the admin's login session for the day
        @admin_login = Admin.new(@engaged_rooms_status)
    end

    def test_can_return_group_of_guests()
        #Putting individual guests in their group
        @admin_login.assign_guest_to_group(@guest1)
        @admin_login.assign_guest_to_group(@guest2)
        @admin_login.assign_guest_to_group(@guest3)
        #Returning that group
        result = @admin_login.return_group_of_guests()
        assert_equal([@guest1, @guest2, @guest3], result)
    end

    def test_can_return_vacant_room_confirmation()
        result = @regular_room.get_guests_in_room()

        assert_equal(:room_vacant, result)
    end

    def test_can_assign_group_to_empty_room()
        #Create group of guests
        @admin_login.assign_guest_to_group(@guest4)
        @admin_login.assign_guest_to_group(@guest5)
        @admin_login.assign_guest_to_group(@guest6)
        guest_group = @admin_login.return_group_of_guests()
        #Assign that group to an empty room
        @admin_login.assign_group_to_room(@regular_room, @waiting_room, guest_group)

        assert_equal(true, @admin_login.engaged_rooms_status[@regular_room])
        assert_equal(guest_group, @regular_room.get_guests_in_room())
    end

    def test_can_assign_guests_to_waiting_room_if_another_room_is_full()
        #Create first test group
        @admin_login.assign_guest_to_group(@guest1)
        @admin_login.assign_guest_to_group(@guest2)
        @admin_login.assign_guest_to_group(@guest3)
        first_guest_group = @admin_login.return_group_of_guests()
        #Assign first test group to regular room
        @admin_login.assign_group_to_room(@regular_room, @waiting_room, first_guest_group)
        #Create second test group to test if they can go to the waiting room for now
        second_guest_group = [@guest4, @guest5, @guest6]
        @admin_login.assign_group_to_room(@regular_room, @waiting_room, second_guest_group)

        assert_equal(true, @admin_login.engaged_rooms_status[@waiting_room])
        assert_equal(second_guest_group, @waiting_room.get_guests_in_room())
    end

    def test_creating_a_non_explicit_playlist_for_a_room()
        @admin_login.create_non_explicit_playlist_for_room(@waiting_room, @all_songs)
        non_explicit_songs = [@song1, @song2, @song4]
        assert_equal(non_explicit_songs, @waiting_room.return_songs_in_room_playlist())
    end

    def test_creating_an_explicit_playlist_for_a_room()
        @admin_login.create_explicit_playlist_for_room(@regular_room, @all_songs)
        explicit_songs = [@song3, @song5]
        assert_equal(explicit_songs, @regular_room.return_songs_in_room_playlist())
    end

    def test_resetting_a_room_after_all_guests_leave()
        #First add some guests to a room
        @admin_login.assign_guest_to_group(@guest1)
        @admin_login.assign_guest_to_group(@guest2)
        @admin_login.assign_guest_to_group(@guest3)
        guest_group = @admin_login.return_group_of_guests()

        @admin_login.assign_group_to_room(@regular_room, @waiting_room, guest_group)

        #Then remove those guests to test if the room can be 
        #reset to its default value
        @regular_room.remove_guest_from_group_in_room(@guest1)
        @regular_room.remove_guest_from_group_in_room(@guest2)
        @regular_room.remove_guest_from_group_in_room(@guest3)

        @admin_login.reset_room_if_empty(@regular_room)
        assert_equal(nil, @admin_login.engaged_rooms_status[@regular_room])
    end


end