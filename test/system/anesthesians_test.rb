require "application_system_test_case"

class AnesthesiansTest < ApplicationSystemTestCase
  setup do
    @anesthesian = anesthesians(:one)
  end

  test "visiting the index" do
    visit anesthesians_url
    assert_selector "h1", text: "Anesthesians"
  end

  test "creating a Anesthesian" do
    visit anesthesians_url
    click_on "New Anesthesian"

    fill_in "Hospital", with: @anesthesian.hospital_id
    fill_in "Name", with: @anesthesian.name
    click_on "Create Anesthesian"

    assert_text "Anesthesian was successfully created"
    click_on "Back"
  end

  test "updating a Anesthesian" do
    visit anesthesians_url
    click_on "Edit", match: :first

    fill_in "Hospital", with: @anesthesian.hospital_id
    fill_in "Name", with: @anesthesian.name
    click_on "Update Anesthesian"

    assert_text "Anesthesian was successfully updated"
    click_on "Back"
  end

  test "destroying a Anesthesian" do
    visit anesthesians_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Anesthesian was successfully destroyed"
  end
end
