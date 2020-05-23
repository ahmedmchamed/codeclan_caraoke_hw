class Rooms

    attr_reader :room_name, :playlist, :entry_fee

    def initialize(room_name, playlist = [], entry_fee)
        @room_name = room_name
        @playlist = playlist
        @entry_fee = entry_fee
        @guests_in_room = []
        @time_limit = 600
    end

    def get_guests_in_room()
        if @guests_in_room.empty?()
            return "Room is vacant"
        else
            return @guests_in_room
        end
    end

    def assign_group_of_guests_to_room(group)
        @guests_in_room = group
    end

    def create_playlist_for_room(song)
        @playlist.push(song)
    end

    def guest_yells_for_favourite_song(room_playlist, guest)
        song_names = @room_playlist.find_all { |song| song.name() }
        guest_favourite_song = guest.favourite_song()
        return "One more tune!" if song_names.include?(guest_favourite_song)
    end

end