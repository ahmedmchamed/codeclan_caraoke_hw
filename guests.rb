class Guests

    attr_reader :name, :age, :wallet, :favourite_song

    #Need to know the guest's age for room admission
    def initialize(name, age, wallet, favourite_song)
        @name = name
        @age = age
        @wallet = wallet
        @favourite_song = favourite_song
    end

end