require 'test_helper'

class OrSchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @or_schedule = or_schedules(:one)
  end

  test "should get index" do
    get or_schedules_url
    assert_response :success
  end

  test "should get new" do
    get new_or_schedule_url
    assert_response :success
  end

  test "should create or_schedule" do
    assert_difference('OrSchedule.count') do
      post or_schedules_url, params: { or_schedule: { anesthesian_id: @or_schedule.anesthesian_id, circulating_nurse_id: @or_schedule.circulating_nurse_id, patient_id: @or_schedule.patient_id, procedure_type: @or_schedule.procedure_type, schedule_order_id: @or_schedule.schedule_order_id, scheduled_date: @or_schedule.scheduled_date, scheduled_time: @or_schedule.scheduled_time, scrub_nurse_id: @or_schedule.scrub_nurse_id, surgeon_id: @or_schedule.surgeon_id, user_id: @or_schedule.user_id } }
    end

    assert_redirected_to or_schedule_url(OrSchedule.last)
  end

  test "should show or_schedule" do
    get or_schedule_url(@or_schedule)
    assert_response :success
  end

  test "should get edit" do
    get edit_or_schedule_url(@or_schedule)
    assert_response :success
  end

  test "should update or_schedule" do
    patch or_schedule_url(@or_schedule), params: { or_schedule: { anesthesian_id: @or_schedule.anesthesian_id, circulating_nurse_id: @or_schedule.circulating_nurse_id, patient_id: @or_schedule.patient_id, procedure_type: @or_schedule.procedure_type, schedule_order_id: @or_schedule.schedule_order_id, scheduled_date: @or_schedule.scheduled_date, scheduled_time: @or_schedule.scheduled_time, scrub_nurse_id: @or_schedule.scrub_nurse_id, surgeon_id: @or_schedule.surgeon_id, user_id: @or_schedule.user_id } }
    assert_redirected_to or_schedule_url(@or_schedule)
  end

  test "should destroy or_schedule" do
    assert_difference('OrSchedule.count', -1) do
      delete or_schedule_url(@or_schedule)
    end

    assert_redirected_to or_schedules_url
  end
end
