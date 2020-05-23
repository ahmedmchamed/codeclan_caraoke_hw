require('pry')
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

        @song1 = Songs.new("Bohemian Rhapsody", "Queen", 360, false)
        @song2 = Songs.new("Introdiction", "Scroobius Pip", 210, true)
        @song3 = Songs.new("Never Gonna Give You Up", "Rick Astley", 210, false)
        @song4 = Songs.new("Calum's Road", "Capercaillie", 145, false)
        @song5 = Songs.new("Jump Around", "House of Pain", 215, true)

        @all_songs = [@song1, @song2, @song3, @song4, @song5]

        #Testing for a family in a family room
        @parent_or_guardian1 = Guests.new("Vicky", 45, 100, "Calum's Road", :family_room)
        @parent_or_guardian2 = Guests.new("Charles", 52, 90, "Smells Like Teen Spirit", :family_room)
        @child1 = Guests.new("Elsie", 8, 2, "Let It Go", :family_room)
        @child2 = Guests.new("Morven", 9, 2, "Mowana", :family_room)

        #Testing for a group of old dears in the geriatrics room
        @old_dear1 = Guests.new("Edith", 87, 60, "How Great Thou Art", :geriatrics_room)
        @old_dear2 = Guests.new("Gwyneth", 84, 65, "Summertime", :geriatrics_room)
        @old_dear3 = Guests.new("Eunice", 89, 75, "Jump Around", :geriatrics_room)

        #Defining the rooms and their names
        @regular_room = Rooms.new("Regular room", 20)
        @family_room = Rooms.new("Family room", 15)
        @geriatrics_room = Rooms.new("Geriatrics room", 10)
        @waiting_room = Rooms.new("Waiting room", 0)

        @engaged_rooms_status = {
            @regular_room => nil,
            @family_room => nil,
            @geriatrics_room => nil,
            @waiting_room => nil
        }

        #Defining the admin's login session for the day
        @admin_login = Admin.new(@engaged_rooms_status)

    end

    def test_can_return_room_entry_fee()
        assert_equal(20, @regular_room.entry_fee())
    end

    def test_can_get_guests_from_room()
        assert_equal(:room_vacant, @regular_room.get_guests_in_room())
    end

    def test_create_playlist_suitable_for_family_room_and_return_playlist()
        @admin_login.create_non_explicit_playlist_for_room(@family_room, @all_songs)
        non_explicit_songs = [@song1, @song3, @song4]
        assert_equal(non_explicit_songs, @family_room.return_songs_in_room_playlist())
    end

    #Note: I'm not sure if this test is irrelevant since it's also
    #kind of done in the admin spec. Wrote here for now to practice.
    def test_can_assign_group_to_room()
        #Admin creates group for family room
        @admin_login.assign_guest_to_group(@parent_or_guardian1)
        @admin_login.assign_guest_to_group(@parent_or_guardian2)
        @admin_login.assign_guest_to_group(@child1)
        @admin_login.assign_guest_to_group(@child2)
        family_group = @admin_login.return_group_of_guests()

        #Group gets assigned to the room
        @family_room.assign_group_of_guests_to_room(family_group)

        assert_equal(family_group, @family_room.get_guests_in_room())
    end

    #Note: I'm not sure if this test is irrelevant here since it's also
    #kind of done in the admin spec. Wrote here for now to practice.
    def test_can_remove_guest_from_room()
        #Same as preceding test for the following lines
        @admin_login.assign_guest_to_group(@parent_or_guardian1)
        @admin_login.assign_guest_to_group(@parent_or_guardian2)
        @admin_login.assign_guest_to_group(@child1)
        @admin_login.assign_guest_to_group(@child2)
        family_group = @admin_login.return_group_of_guests()
        @family_room.assign_group_of_guests_to_room(family_group)

        #Test family removing Elsie because she likes 'Let It Go'
        @family_room.remove_guest_from_group_in_room(@child1)
        new_family_group = [@parent_or_guardian1, @parent_or_guardian2, @child2]
        
        assert_equal(new_family_group, @family_room.get_guests_in_room())
    end

    def test_can_guest_yell_for_favourite_song()
        #Create playlist for room
        @geriatrics_room.create_playlist_for_room(@all_songs)
        #Generate result from function when looping the room's playlist
        result = @geriatrics_room.guest_yells_for_favourite_song(@old_dear3)
        assert_equal("Jump around!!", result)
    end

    def test_get_total_playlist_duration_for_room()
        @regular_room.create_playlist_for_room(@all_songs)

        result = @regular_room.get_total_playlist_time()
        assert_equal(1140, result)
    end


end