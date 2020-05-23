class Guests

    attr_reader :name, :age, :favourite_song, :chosen_room

    #Need to know the guest's age for room admission
    def initialize(name, age, wallet, favourite_song, chosen_room)
        @name = name
        @age = age
        @wallet = wallet
        @favourite_song = favourite_song
        @chosen_room = chosen_room
    end

    def get_wallet_amount()
        return @wallet
    end

    def can_guest_afford_room_entry_fee(group)
        #Loop through each guest in a group and check if they have
        #enough funds to book a room
        guests_available_funds = group.reduce(0) do |total_amount, guest|
            total_amount + guest.wallet()
        end
    end

end