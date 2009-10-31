require 'test_helper'

class PositionTest < ActiveSupport::TestCase

  test "generates a code for new instances" do
    position = Position.new
    position.save
    assert_not_nil position.code
  end
  
  test "generates a spell phrase for instances" do
    position = Position.new
    position.save
    assert_not_nil position.spell
  end
  
  test "the latitude and the longitude are required" do
    position = Position.new
    position.save
    assert_not_equal 0, position.errors.count

    position = Position.new
    position.latitude = "2.34"
    position.save
    assert_not_equal 0, position.errors.count

    position = Position.new
    position.longitude = "2.34"
    position.save
    assert_not_equal 0, position.errors.count

    position = Position.new
    position.latitude = "2.34"
    position.longitude = "2.34"
    position.save
    assert_equal 0, position.errors.count
  end
  
  test "the latitude and the longitude must be numbers" do
    position = Position.new
    position.save
    assert_not_equal 0, position.errors.count

    position = Position.new
    position.latitude = "aaaaaa"
    position.save
    assert_not_equal 0, position.errors.count

    position = Position.new
    position.longitude = "bbbbbbbb"
    position.save
    assert_not_equal 0, position.errors.count

    position = Position.new
    position.latitude = "2.34"
    position.longitude = "2.34"
    position.save
    assert_equal 0, position.errors.count
  end

end
