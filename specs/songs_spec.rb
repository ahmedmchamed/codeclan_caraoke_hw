require('minitest/autorun')
require('minitest/reporters')
require_relative('../songs')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestSong < MiniTest::Test

    def setup()
        @song1 = Songs.new("Crash", "The Primitives", 162, false)
    end

    def test_can_return_song_name()
        assert_equal("Crash", @song1.name)
    end

    def test_can_return_band_name()
        assert_equal("The Primitives", @song1.artist())
    end

    def test_can_return_song_length()
        assert_equal(162, @song1.song_length())
    end

    def test_can_return_song_explicit_or_not()
        assert_equal(false, @song1.explicit_or_not())
    end

end