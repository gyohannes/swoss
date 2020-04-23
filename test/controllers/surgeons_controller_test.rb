require 'test_helper'

class SurgeonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @surgeon = surgeons(:one)
  end

  test "should get index" do
    get surgeons_url
    assert_response :success
  end

  test "should get new" do
    get new_surgeon_url
    assert_response :success
  end

  test "should create surgeon" do
    assert_difference('Surgeon.count') do
      post surgeons_url, params: { surgeon: { hospital_id: @surgeon.hospital_id, name: @surgeon.name } }
    end

    assert_redirected_to surgeon_url(Surgeon.last)
  end

  test "should show surgeon" do
    get surgeon_url(@surgeon)
    assert_response :success
  end

  test "should get edit" do
    get edit_surgeon_url(@surgeon)
    assert_response :success
  end

  test "should update surgeon" do
    patch surgeon_url(@surgeon), params: { surgeon: { hospital_id: @surgeon.hospital_id, name: @surgeon.name } }
    assert_redirected_to surgeon_url(@surgeon)
  end

  test "should destroy surgeon" do
    assert_difference('Surgeon.count', -1) do
      delete surgeon_url(@surgeon)
    end

    assert_redirected_to surgeons_url
  end
end
