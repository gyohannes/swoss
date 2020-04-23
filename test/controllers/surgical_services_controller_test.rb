require 'test_helper'

class SurgicalServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @surgical_service = surgical_services(:one)
  end

  test "should get index" do
    get surgical_services_url
    assert_response :success
  end

  test "should get new" do
    get new_surgical_service_url
    assert_response :success
  end

  test "should create surgical_service" do
    assert_difference('SurgicalService.count') do
      post surgical_services_url, params: { surgical_service: { anesthesia_time: @surgical_service.anesthesia_time, immediate_postoperative_outcome: @surgical_service.immediate_postoperative_outcome, incision_time: @surgical_service.incision_time, or_schedule_id: @surgical_service.or_schedule_id, or_table_id: @surgical_service.or_table_id, post_schedule_status: @surgical_service.post_schedule_status, reason_for_cancellation: @surgical_service.reason_for_cancellation, reason_for_death: @surgical_service.reason_for_death, surgery_end_time: @surgical_service.surgery_end_time, surgical_safety_checklist_completed: @surgical_service.surgical_safety_checklist_completed, user_id: @surgical_service.user_id } }
    end

    assert_redirected_to surgical_service_url(SurgicalService.last)
  end

  test "should show surgical_service" do
    get surgical_service_url(@surgical_service)
    assert_response :success
  end

  test "should get edit" do
    get edit_surgical_service_url(@surgical_service)
    assert_response :success
  end

  test "should update surgical_service" do
    patch surgical_service_url(@surgical_service), params: { surgical_service: { anesthesia_time: @surgical_service.anesthesia_time, immediate_postoperative_outcome: @surgical_service.immediate_postoperative_outcome, incision_time: @surgical_service.incision_time, or_schedule_id: @surgical_service.or_schedule_id, or_table_id: @surgical_service.or_table_id, post_schedule_status: @surgical_service.post_schedule_status, reason_for_cancellation: @surgical_service.reason_for_cancellation, reason_for_death: @surgical_service.reason_for_death, surgery_end_time: @surgical_service.surgery_end_time, surgical_safety_checklist_completed: @surgical_service.surgical_safety_checklist_completed, user_id: @surgical_service.user_id } }
    assert_redirected_to surgical_service_url(@surgical_service)
  end

  test "should destroy surgical_service" do
    assert_difference('SurgicalService.count', -1) do
      delete surgical_service_url(@surgical_service)
    end

    assert_redirected_to surgical_services_url
  end
end
