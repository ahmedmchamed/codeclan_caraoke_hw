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

end