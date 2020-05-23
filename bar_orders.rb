class BarOrders

    attr_reader :total_tab, :room

    def initialize()
        @total_tab = 0
        @room = nil
    end

    def assign_room_name(room)
        @room = room
    end

    def add_purchased_item_cost_to_tab(amount)
        @total_tab += amount
    end

end