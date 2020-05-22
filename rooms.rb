class Rooms

    attr_reader :room_name, :playlist, :entry_fee

    def initialize(room_name, guests_in_room = [], playlist = [], entry_fee)
        @room_name = room_name
        @guests_in_room = guests_in_room
        @playlist = playlist
        @entry_fee = entry_fee
    end

    def get_guests_in_room()
        return @guests_in_room
    end

end