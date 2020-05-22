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

end