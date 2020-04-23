require "application_system_test_case"

class SurgeonsTest < ApplicationSystemTestCase
  setup do
    @surgeon = surgeons(:one)
  end

  test "visiting the index" do
    visit surgeons_url
    assert_selector "h1", text: "Surgeons"
  end

  test "creating a Surgeon" do
    visit surgeons_url
    click_on "New Surgeon"

    fill_in "Hospital", with: @surgeon.hospital_id
    fill_in "Name", with: @surgeon.name
    click_on "Create Surgeon"

    assert_text "Surgeon was successfully created"
    click_on "Back"
  end

  test "updating a Surgeon" do
    visit surgeons_url
    click_on "Edit", match: :first

    fill_in "Hospital", with: @surgeon.hospital_id
    fill_in "Name", with: @surgeon.name
    click_on "Update Surgeon"

    assert_text "Surgeon was successfully updated"
    click_on "Back"
  end

  test "destroying a Surgeon" do
    visit surgeons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Surgeon was successfully destroyed"
  end
end
