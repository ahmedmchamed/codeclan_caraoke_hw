require('minitest/autorun')
require('minitest/reporters')
require_relative('../guests')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestGuest < MiniTest::Test

    def setup()
        @guest = Guests.new("Jim", 41, 60, "All Things Bright And Beautiful")
    end

    def test_get_guest_name()
        assert_equal("Jim", @guest.name())
    end

    def test_get_guest_age()
        assert_equal(41, @guest.age())
    end

    def test_get_guest_wallet_amount()
        assert_equal(60, @guest.get_wallet_amount())
    end

    def test_get_guest_favourite_song()
        assert_equal("All Things Bright And Beautiful", @guest.favourite_song())
    end

end