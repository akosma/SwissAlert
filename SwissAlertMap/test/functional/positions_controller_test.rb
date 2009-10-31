require 'test_helper'

class PositionsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:positions)
  end
  
  test "if index controller has a code parameter, it redirects to the show action" do
    get :index, :code => "ABC"
    assert_redirected_to position_url("ABC")
  end
  
  test "when requesting on a normal browser, a map is drawn" do
    get :index
    assert_not_nil assigns(:map)
    assert_not_nil assigns(:positions)
    
    get :show, :code => "ABC"
    assert_not_nil assigns(:map)
    assert_not_nil assigns(:positions)
  end
  
  test "when requesting json, only the list is generated" do
    @request.env["HTTP_ACCEPT"] = "application/javascript"
    get :index
    assert_nil assigns(:map)
    assert_not_nil assigns(:positions)    

    @request.env["HTTP_ACCEPT"] = "application/javascript"
    get :show, :code => "ABC"
    assert_nil assigns(:map)
    assert_not_nil assigns(:positions)    
  end

  test "when requesting xml, only the list is generated" do
    @request.env["HTTP_ACCEPT"] = "text/xml"
    get :index
    assert_nil assigns(:map)
    assert_not_nil assigns(:positions)    

    @request.env["HTTP_ACCEPT"] = "text/xml"
    get :show, :code => "ABC"
    assert_nil assigns(:map)
    assert_not_nil assigns(:positions)    
  end

  test "should create position with a correct POST request" do
    assert_difference('Position.count') do
      post :create, :latitude => 10.0, :longitude => 10.0
    end
    assert_response :redirect
    assert_redirected_to position_url(assigns(:position).code)
  end

  test "should redirect to the index action for invalid POST creation requests" do
    post :create, :latitude => nil, :longitude => "abs"
    assert_response :redirect
    assert_redirected_to root_url
  end
  
  test "should allow to create items with XML requests" do
    @request.env["HTTP_ACCEPT"] = "text/xml"
    assert_difference('Position.count') do
      post :create, :latitude => 10.0, :longitude => 10.0
    end
    assert_equal 0, assigns(:position).errors.count
    assert_not_equal 0, @response.body.length
    assert_response :created
  end

  test "should output errors in invalid XML creation requests" do
    @request.env["HTTP_ACCEPT"] = "text/xml"
    post :create, :latitude => "blah", :longitude => nil
    assert_not_equal 0, assigns(:position).errors.count
    assert_not_equal 0, @response.body.length
    assert_response :unprocessable_entity
  end

  test "should allow to create items with JSON requests" do
    @request.env["HTTP_ACCEPT"] = "application/javascript"
    assert_difference('Position.count') do
      post :create, :latitude => 10.0, :longitude => 10.0
    end
    assert_equal 0, assigns(:position).errors.count
    assert_response :created
    assert_not_equal 0, @response.body.length
  end

  test "should output errors in invalid JSON creation requests" do
    @request.env["HTTP_ACCEPT"] = "application/javascript"
    post :create, :latitude => "blah", :longitude => nil
    assert_not_equal 0, assigns(:position).errors.count
    assert_not_equal 0, @response.body.length
    assert_response :unprocessable_entity
  end

  test "should show position for existing items" do
    get :show, :code => "EHERF"
    assert_response :success
    assert_not_nil assigns(:position)
    assert_equal 1, assigns(:positions).count
  end
  
  test "should display all items when requesting for a nonexisting item" do
    get :show, :code => "whatever_non_existent"
    assert_response :success
    assert assigns(:positions).count > 1
  end

  test "should expose a 404 code for nonexistent items when doing XML requests" do
    @request.env["HTTP_ACCEPT"] = "text/xml"
    get :show, :code => "whatever_non_existent"
    assert_response :not_found
  end

  test "should expose a 404 code for nonexistent items when doing JSON requests" do
    @request.env["HTTP_ACCEPT"] = "application/javascript"
    get :show, :code => "whatever_non_existent"
    assert_response :not_found
  end
end
