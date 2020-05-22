class Admin

    attr_reader

    def initialize(engaged_rooms = {}, groups_waiting_for_room = {})
        @engaged_rooms = engaged_rooms
        @groups_waiting_for_room = groups_waiting_for_room
    end

end