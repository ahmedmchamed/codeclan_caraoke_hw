class Rooms

    attr_reader :room_name, :entry_fee

    def initialize(room_name, playlist = [], entry_fee)
        @room_name = room_name
        @playlist = playlist
        @entry_fee = entry_fee
        @guests_in_room = []
        @time_limit = 900 #time in seconds
    end

    def get_guests_in_room()
        #If the room is empty, return a symbol to 
        #make that clear, otherwise return the group
        if @guests_in_room.empty?()
            return :room_vacant
        else
            return @guests_in_room
        end
    end

    def create_playlist_for_room(list_of_songs)
        @playlist = list_of_songs
    end

    def assign_group_of_guests_to_room(group)
        @guests_in_room = group
    end

    def remove_guest_from_group_in_room(guest)
        @guests_in_room.delete(guest)
    end

    def return_songs_in_room_playlist()
        return @playlist
    end

    def guest_yells_for_favourite_song(guest)
        #Loops through the playlist for the Room instance
        #on which this function is called
        song_names_from_room = @playlist.map { |song| song.name() }
        return "Jump around!!" if song_names_from_room.include?(guest.favourite_song())
    end

    def get_total_playlist_time()
        #Loops through the playlist on for the Room instance 
        #on which this function is called
         return total_playlist_time = @playlist.reduce(0) do |total_music_time, song| 
            total_music_time + song.song_length()
         end

    end


end