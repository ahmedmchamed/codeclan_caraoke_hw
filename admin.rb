class Admin

    attr_reader :engaged_rooms_status

    def initialize(engaged_rooms_status = {})
        #Hash to contain each room as a key, and whether they
        #are engaged with guests or not as a value
        @engaged_rooms_status = engaged_rooms_status
        #Group to hold individual guests to assign to
        #each room
        @group_of_guests = []       
    end

    def assign_guest_to_group(guest)
        @group_of_guests.push(guest)
    end

    def return_group_of_guests()
        return @group_of_guests
    end

    def assign_group_to_room(room, waiting_room, group)
        #Assuming each guests in the group has booked the
        #same room
        return "Incorrect room assignment" if room.room_name() != group[0].chosen_room()
        #If there's no one in the room, then assign group
        #to that room
        if @engaged_rooms_status[room] == nil
            room.assign_group_of_guests_to_room(group)
            @engaged_rooms_status[room] = true
        #If the room is not empty, put group in waiting room
        elsif @engaged_rooms_status[room] != nil
            waiting_room.assign_group_of_guests_to_room(group)
            @engaged_rooms_status[waiting_room] = true
        else
            return
        end
    end

    def create_non_explicit_playlist_for_room(room, list_of_songs)
        #Iterate through all songs and remove ones with 'false' explicit label
        non_explicit_playlist = list_of_songs.find_all { |song| song.explicit_or_not() == false }
        room.create_playlist_for_room(non_explicit_playlist)
    end

    def create_explicit_playlist_for_room(room, list_of_songs)
        #Iterate through all songs and remove ones with 'true' explicit label
        explicit_playlist = list_of_songs.find_all { |song| song.explicit_or_not() == true }
        room.create_playlist_for_room(explicit_playlist)
    end

    def reset_room_if_empty(room)
        if room.get_guests_in_room() == :room_vacant
            @engaged_rooms_status[room] = nil
        end
    end

    def deduct_room_entry_fee_from_group(room, group)
        #Calculate total amount of funds from guests
        guest_funds_available = group.reduce(0) { |total_funds, guest|
            total_funds + guest.get_wallet_amount()
        }
        #Exit the function if funds unavailable from entire group
        return if guest_funds_available < room.entry_fee()

        #Trying to deduct the fee amount from just one of
        #the members of a group, assuming I also don't know
        #the group size
        for index in group.size()
            if group[index].get_wallet_amount() >= room.entry_fee()
                group[index].get_wallet_amount() -= room.entry_fee()
                #return
            end
        end

        # return nil
    end

end