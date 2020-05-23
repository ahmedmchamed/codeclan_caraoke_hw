class Admin

    def initialize(engaged_rooms_status = {})
        @engaged_rooms_status = engaged_rooms_status
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

    # def return_group_in_room(room_name)
    #     if @engaged_rooms_status[room_name] ==  nil
    #         return "Room is vacant"
    #     else
    #         return @engaged_rooms_status[room_name]
    #     end
    # end

    def create_non_explicit_playlist(list_of_songs)
        playlist = list_of_songs.find_all { |song| song.explicit_or_not() == false }
        return playlist
    end

    def create_explicit_playlist(list_of_songs)
        playlist = list_of_songs.find_all { |song| song.explicit_or_not() == true }
        return playlist
    end

    def remove_guest_from_group_in_room(guest, room)
        @engaged_rooms_status[room].delete(guest)
    end

    def reset_room_if_empty(room)
        if @engaged_rooms_status[room].empty?()
            @engaged_rooms_status[room] = nil
        end
    end

end