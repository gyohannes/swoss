require "application_system_test_case"

class OrTablesTest < ApplicationSystemTestCase
  setup do
    @or_table = or_tables(:one)
  end

  test "visiting the index" do
    visit or_tables_url
    assert_selector "h1", text: "Or Tables"
  end

  test "creating a Or table" do
    visit or_tables_url
    click_on "New Or Table"

    fill_in "Code", with: @or_table.code
    fill_in "Hospital", with: @or_table.hospital_id
    fill_in "Name", with: @or_table.name
    click_on "Create Or table"

    assert_text "Or table was successfully created"
    click_on "Back"
  end

  test "updating a Or table" do
    visit or_tables_url
    click_on "Edit", match: :first

    fill_in "Code", with: @or_table.code
    fill_in "Hospital", with: @or_table.hospital_id
    fill_in "Name", with: @or_table.name
    click_on "Update Or table"

    assert_text "Or table was successfully updated"
    click_on "Back"
  end

  test "destroying a Or table" do
    visit or_tables_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Or table was successfully destroyed"
  end
end
