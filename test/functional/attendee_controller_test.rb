require 'test_helper'

class AttendeeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
