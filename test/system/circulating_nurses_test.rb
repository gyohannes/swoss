require "application_system_test_case"

class CirculatingNursesTest < ApplicationSystemTestCase
  setup do
    @circulating_nurse = circulating_nurses(:one)
  end

  test "visiting the index" do
    visit circulating_nurses_url
    assert_selector "h1", text: "Circulating Nurses"
  end

  test "creating a Circulating nurse" do
    visit circulating_nurses_url
    click_on "New Circulating Nurse"

    fill_in "Hospital", with: @circulating_nurse.hospital_id
    fill_in "Name", with: @circulating_nurse.name
    click_on "Create Circulating nurse"

    assert_text "Circulating nurse was successfully created"
    click_on "Back"
  end

  test "updating a Circulating nurse" do
    visit circulating_nurses_url
    click_on "Edit", match: :first

    fill_in "Hospital", with: @circulating_nurse.hospital_id
    fill_in "Name", with: @circulating_nurse.name
    click_on "Update Circulating nurse"

    assert_text "Circulating nurse was successfully updated"
    click_on "Back"
  end

  test "destroying a Circulating nurse" do
    visit circulating_nurses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Circulating nurse was successfully destroyed"
  end
end
