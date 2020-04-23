require "application_system_test_case"

class WardsTest < ApplicationSystemTestCase
  setup do
    @ward = wards(:one)
  end

  test "visiting the index" do
    visit wards_url
    assert_selector "h1", text: "Wards"
  end

  test "creating a Ward" do
    visit wards_url
    click_on "New Ward"

    fill_in "Hospital", with: @ward.hospital_id
    fill_in "Name", with: @ward.name
    click_on "Create Ward"

    assert_text "Ward was successfully created"
    click_on "Back"
  end

  test "updating a Ward" do
    visit wards_url
    click_on "Edit", match: :first

    fill_in "Hospital", with: @ward.hospital_id
    fill_in "Name", with: @ward.name
    click_on "Update Ward"

    assert_text "Ward was successfully updated"
    click_on "Back"
  end

  test "destroying a Ward" do
    visit wards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ward was successfully destroyed"
  end
end
