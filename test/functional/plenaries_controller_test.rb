require 'test_helper'

class PlenariesControllerTest < ActionController::TestCase
  setup do
    @plenary = plenaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plenaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plenary" do
    assert_difference('Plenary.count') do
      post :create, plenary: { conference_id: @plenary.conference_id, content: @plenary.content, presenter: @plenary.presenter, title: @plenary.title, user_id: @plenary.user_id }
    end

    assert_redirected_to plenary_path(assigns(:plenary))
  end

  test "should show plenary" do
    get :show, id: @plenary
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plenary
    assert_response :success
  end

  test "should update plenary" do
    put :update, id: @plenary, plenary: { conference_id: @plenary.conference_id, content: @plenary.content, presenter: @plenary.presenter, title: @plenary.title, user_id: @plenary.user_id }
    assert_redirected_to plenary_path(assigns(:plenary))
  end

  test "should destroy plenary" do
    assert_difference('Plenary.count', -1) do
      delete :destroy, id: @plenary
    end

    assert_redirected_to plenaries_path
  end
end
