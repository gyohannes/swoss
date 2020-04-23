require 'test_helper'

class AnesthesiansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @anesthesian = anesthesians(:one)
  end

  test "should get index" do
    get anesthesians_url
    assert_response :success
  end

  test "should get new" do
    get new_anesthesian_url
    assert_response :success
  end

  test "should create anesthesian" do
    assert_difference('Anesthesian.count') do
      post anesthesians_url, params: { anesthesian: { hospital_id: @anesthesian.hospital_id, name: @anesthesian.name } }
    end

    assert_redirected_to anesthesian_url(Anesthesian.last)
  end

  test "should show anesthesian" do
    get anesthesian_url(@anesthesian)
    assert_response :success
  end

  test "should get edit" do
    get edit_anesthesian_url(@anesthesian)
    assert_response :success
  end

  test "should update anesthesian" do
    patch anesthesian_url(@anesthesian), params: { anesthesian: { hospital_id: @anesthesian.hospital_id, name: @anesthesian.name } }
    assert_redirected_to anesthesian_url(@anesthesian)
  end

  test "should destroy anesthesian" do
    assert_difference('Anesthesian.count', -1) do
      delete anesthesian_url(@anesthesian)
    end

    assert_redirected_to anesthesians_url
  end
end
