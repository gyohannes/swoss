require 'test_helper'

class PhoneCallsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @phone_call = phone_calls(:one)
  end

  test "should get index" do
    get phone_calls_url
    assert_response :success
  end

  test "should get new" do
    get new_phone_call_url
    assert_response :success
  end

  test "should create phone_call" do
    assert_difference('PhoneCall.count') do
      post phone_calls_url, params: { phone_call: { action: @phone_call.action, admission_id: @phone_call.admission_id, information: @phone_call.information, new_appointment: @phone_call.new_appointment, patient_response: @phone_call.patient_response } }
    end

    assert_redirected_to phone_call_url(PhoneCall.last)
  end

  test "should show phone_call" do
    get phone_call_url(@phone_call)
    assert_response :success
  end

  test "should get edit" do
    get edit_phone_call_url(@phone_call)
    assert_response :success
  end

  test "should update phone_call" do
    patch phone_call_url(@phone_call), params: { phone_call: { action: @phone_call.action, admission_id: @phone_call.admission_id, information: @phone_call.information, new_appointment: @phone_call.new_appointment, patient_response: @phone_call.patient_response } }
    assert_redirected_to phone_call_url(@phone_call)
  end

  test "should destroy phone_call" do
    assert_difference('PhoneCall.count', -1) do
      delete phone_call_url(@phone_call)
    end

    assert_redirected_to phone_calls_url
  end
end
