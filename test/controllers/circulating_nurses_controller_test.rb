require 'test_helper'

class CirculatingNursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @circulating_nurse = circulating_nurses(:one)
  end

  test "should get index" do
    get circulating_nurses_url
    assert_response :success
  end

  test "should get new" do
    get new_circulating_nurse_url
    assert_response :success
  end

  test "should create circulating_nurse" do
    assert_difference('CirculatingNurse.count') do
      post circulating_nurses_url, params: { circulating_nurse: { hospital_id: @circulating_nurse.hospital_id, name: @circulating_nurse.name } }
    end

    assert_redirected_to circulating_nurse_url(CirculatingNurse.last)
  end

  test "should show circulating_nurse" do
    get circulating_nurse_url(@circulating_nurse)
    assert_response :success
  end

  test "should get edit" do
    get edit_circulating_nurse_url(@circulating_nurse)
    assert_response :success
  end

  test "should update circulating_nurse" do
    patch circulating_nurse_url(@circulating_nurse), params: { circulating_nurse: { hospital_id: @circulating_nurse.hospital_id, name: @circulating_nurse.name } }
    assert_redirected_to circulating_nurse_url(@circulating_nurse)
  end

  test "should destroy circulating_nurse" do
    assert_difference('CirculatingNurse.count', -1) do
      delete circulating_nurse_url(@circulating_nurse)
    end

    assert_redirected_to circulating_nurses_url
  end
end
