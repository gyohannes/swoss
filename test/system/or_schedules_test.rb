require "application_system_test_case"

class OrSchedulesTest < ApplicationSystemTestCase
  setup do
    @or_schedule = or_schedules(:one)
  end

  test "visiting the index" do
    visit or_schedules_url
    assert_selector "h1", text: "Or Schedules"
  end

  test "creating a Or schedule" do
    visit or_schedules_url
    click_on "New Or Schedule"

    fill_in "Anesthesian", with: @or_schedule.anesthesian_id
    fill_in "Circulating nurse", with: @or_schedule.circulating_nurse_id
    fill_in "Patient", with: @or_schedule.patient_id
    fill_in "Procedure type", with: @or_schedule.procedure_type
    fill_in "Schedule order", with: @or_schedule.schedule_order_id
    fill_in "Scheduled date", with: @or_schedule.scheduled_date
    fill_in "Scheduled time", with: @or_schedule.scheduled_time
    fill_in "Scrub nurse", with: @or_schedule.scrub_nurse_id
    fill_in "Surgeon", with: @or_schedule.surgeon_id
    fill_in "User", with: @or_schedule.user_id
    click_on "Create Or schedule"

    assert_text "Or schedule was successfully created"
    click_on "Back"
  end

  test "updating a Or schedule" do
    visit or_schedules_url
    click_on "Edit", match: :first

    fill_in "Anesthesian", with: @or_schedule.anesthesian_id
    fill_in "Circulating nurse", with: @or_schedule.circulating_nurse_id
    fill_in "Patient", with: @or_schedule.patient_id
    fill_in "Procedure type", with: @or_schedule.procedure_type
    fill_in "Schedule order", with: @or_schedule.schedule_order_id
    fill_in "Scheduled date", with: @or_schedule.scheduled_date
    fill_in "Scheduled time", with: @or_schedule.scheduled_time
    fill_in "Scrub nurse", with: @or_schedule.scrub_nurse_id
    fill_in "Surgeon", with: @or_schedule.surgeon_id
    fill_in "User", with: @or_schedule.user_id
    click_on "Update Or schedule"

    assert_text "Or schedule was successfully updated"
    click_on "Back"
  end

  test "destroying a Or schedule" do
    visit or_schedules_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Or schedule was successfully destroyed"
  end
end
