require 'test_helper'

class ProblemsControllerTest < ActionController::TestCase
  setup do
    @problem = problems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:problems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create problem" do
    assert_difference('Problem.count') do
      post :create, problem: { category_id: @problem.category_id, cause: @problem.cause, effect: @problem.effect, kabupaten_id: @problem.kabupaten_id, kelurahan_id: @problem.kelurahan_id, province_id: @problem.province_id, reported_by: @problem.reported_by, summary: @problem.summary, symptom: @problem.symptom, title: @problem.title, urgency: @problem.urgency }
    end

    assert_redirected_to problem_path(assigns(:problem))
  end

  test "should show problem" do
    get :show, id: @problem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @problem
    assert_response :success
  end

  test "should update problem" do
    patch :update, id: @problem, problem: { category_id: @problem.category_id, cause: @problem.cause, effect: @problem.effect, kabupaten_id: @problem.kabupaten_id, kelurahan_id: @problem.kelurahan_id, province_id: @problem.province_id, reported_by: @problem.reported_by, summary: @problem.summary, symptom: @problem.symptom, title: @problem.title, urgency: @problem.urgency }
    assert_redirected_to problem_path(assigns(:problem))
  end

  test "should destroy problem" do
    assert_difference('Problem.count', -1) do
      delete :destroy, id: @problem
    end

    assert_redirected_to problems_path
  end
end
