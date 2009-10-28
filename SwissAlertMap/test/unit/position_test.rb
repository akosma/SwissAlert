require 'test_helper'

class PositionTest < ActiveSupport::TestCase

  test "generates a code for new instances" do
    position = Position.new
    position.save
    assert_not_nil position.code
  end

end
