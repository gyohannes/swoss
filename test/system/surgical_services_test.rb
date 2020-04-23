require "application_system_test_case"

class SurgicalServicesTest < ApplicationSystemTestCase
  setup do
    @surgical_service = surgical_services(:one)
  end

  test "visiting the index" do
    visit surgical_services_url
    assert_selector "h1", text: "Surgical Services"
  end

  test "creating a Surgical service" do
    visit surgical_services_url
    click_on "New Surgical Service"

    fill_in "Anesthesia time", with: @surgical_service.anesthesia_time
    fill_in "Immediate postoperative outcome", with: @surgical_service.immediate_postoperative_outcome
    fill_in "Incision time", with: @surgical_service.incision_time
    fill_in "Or schedule", with: @surgical_service.or_schedule_id
    fill_in "Or table", with: @surgical_service.or_table_id
    fill_in "Post schedule status", with: @surgical_service.post_schedule_status
    fill_in "Reason for cancellation", with: @surgical_service.reason_for_cancellation
    fill_in "Reason for death", with: @surgical_service.reason_for_death
    fill_in "Surgery end time", with: @surgical_service.surgery_end_time
    check "Surgical safety checklist completed" if @surgical_service.surgical_safety_checklist_completed
    fill_in "User", with: @surgical_service.user_id
    click_on "Create Surgical service"

    assert_text "Surgical service was successfully created"
    click_on "Back"
  end

  test "updating a Surgical service" do
    visit surgical_services_url
    click_on "Edit", match: :first

    fill_in "Anesthesia time", with: @surgical_service.anesthesia_time
    fill_in "Immediate postoperative outcome", with: @surgical_service.immediate_postoperative_outcome
    fill_in "Incision time", with: @surgical_service.incision_time
    fill_in "Or schedule", with: @surgical_service.or_schedule_id
    fill_in "Or table", with: @surgical_service.or_table_id
    fill_in "Post schedule status", with: @surgical_service.post_schedule_status
    fill_in "Reason for cancellation", with: @surgical_service.reason_for_cancellation
    fill_in "Reason for death", with: @surgical_service.reason_for_death
    fill_in "Surgery end time", with: @surgical_service.surgery_end_time
    check "Surgical safety checklist completed" if @surgical_service.surgical_safety_checklist_completed
    fill_in "User", with: @surgical_service.user_id
    click_on "Update Surgical service"

    assert_text "Surgical service was successfully updated"
    click_on "Back"
  end

  test "destroying a Surgical service" do
    visit surgical_services_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Surgical service was successfully destroyed"
  end
end
