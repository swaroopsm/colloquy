require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase
  setup do
    @submission = submissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:submissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create submission" do
    assert_difference('Submission.count') do
      post :create, submission: { approved: @submission.approved, authors: @submission.authors, bursary_for: @submission.bursary_for, bursary_why: @submission.bursary_why, conference_id: @submission.conference_id, content: @submission.content, preference: @submission.preference, title: @submission.title, user_id: @submission.user_id }
    end

    assert_redirected_to submission_path(assigns(:submission))
  end

  test "should show submission" do
    get :show, id: @submission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @submission
    assert_response :success
  end

  test "should update submission" do
    put :update, id: @submission, submission: { approved: @submission.approved, authors: @submission.authors, bursary_for: @submission.bursary_for, bursary_why: @submission.bursary_why, conference_id: @submission.conference_id, content: @submission.content, preference: @submission.preference, title: @submission.title, user_id: @submission.user_id }
    assert_redirected_to submission_path(assigns(:submission))
  end

  test "should destroy submission" do
    assert_difference('Submission.count', -1) do
      delete :destroy, id: @submission
    end

    assert_redirected_to submissions_path
  end
end
