require 'test_helper'

class PositionsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:positions)
  end

  test "should create position" do
    assert_difference('Position.count') do
      post :create, :latitude => 10.0, :longitude => 10.0
    end
  end

  test "should show position" do
    get :show, :code => "ehe4rf"
    assert_response :success
    assert_not_nil assigns(:position)
  end

end
