class Songs

    attr_reader :name, :artist, :song_length, :explicit_or_not

    #Need to know whether song is explicit or not depending on guests in room
    def initialize(name, artist, song_length, explicit_or_not)
        @name = name
        @artist = artist
        @song_length = song_length
        @explicit_or_not = explicit_or_not
    end

end