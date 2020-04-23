require 'test_helper'

class ScrubNursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scrub_nurse = scrub_nurses(:one)
  end

  test "should get index" do
    get scrub_nurses_url
    assert_response :success
  end

  test "should get new" do
    get new_scrub_nurse_url
    assert_response :success
  end

  test "should create scrub_nurse" do
    assert_difference('ScrubNurse.count') do
      post scrub_nurses_url, params: { scrub_nurse: { hospital_id: @scrub_nurse.hospital_id, name: @scrub_nurse.name } }
    end

    assert_redirected_to scrub_nurse_url(ScrubNurse.last)
  end

  test "should show scrub_nurse" do
    get scrub_nurse_url(@scrub_nurse)
    assert_response :success
  end

  test "should get edit" do
    get edit_scrub_nurse_url(@scrub_nurse)
    assert_response :success
  end

  test "should update scrub_nurse" do
    patch scrub_nurse_url(@scrub_nurse), params: { scrub_nurse: { hospital_id: @scrub_nurse.hospital_id, name: @scrub_nurse.name } }
    assert_redirected_to scrub_nurse_url(@scrub_nurse)
  end

  test "should destroy scrub_nurse" do
    assert_difference('ScrubNurse.count', -1) do
      delete scrub_nurse_url(@scrub_nurse)
    end

    assert_redirected_to scrub_nurses_url
  end
end
