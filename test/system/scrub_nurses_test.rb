require "application_system_test_case"

class ScrubNursesTest < ApplicationSystemTestCase
  setup do
    @scrub_nurse = scrub_nurses(:one)
  end

  test "visiting the index" do
    visit scrub_nurses_url
    assert_selector "h1", text: "Scrub Nurses"
  end

  test "creating a Scrub nurse" do
    visit scrub_nurses_url
    click_on "New Scrub Nurse"

    fill_in "Hospital", with: @scrub_nurse.hospital_id
    fill_in "Name", with: @scrub_nurse.name
    click_on "Create Scrub nurse"

    assert_text "Scrub nurse was successfully created"
    click_on "Back"
  end

  test "updating a Scrub nurse" do
    visit scrub_nurses_url
    click_on "Edit", match: :first

    fill_in "Hospital", with: @scrub_nurse.hospital_id
    fill_in "Name", with: @scrub_nurse.name
    click_on "Update Scrub nurse"

    assert_text "Scrub nurse was successfully updated"
    click_on "Back"
  end

  test "destroying a Scrub nurse" do
    visit scrub_nurses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Scrub nurse was successfully destroyed"
  end
end
