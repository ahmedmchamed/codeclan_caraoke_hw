class Rooms


    def initialize(room_name, guests_in_room = [], playlist = [], waiting_list = [], entry_fee)
        @room_name = room_name
        @guests_in_room = guests_in_room
        @playlist = playlist
        @waiting_list = waiting_list
        @entry_fee = entry_fee
        @groups_waiting_per_room = Hash.new(0)
    end



end