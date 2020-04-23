require "application_system_test_case"

class ProcedureCategoriesTest < ApplicationSystemTestCase
  setup do
    @procedure_category = procedure_categories(:one)
  end

  test "visiting the index" do
    visit procedure_categories_url
    assert_selector "h1", text: "Procedure Categories"
  end

  test "creating a Procedure category" do
    visit procedure_categories_url
    click_on "New Procedure Category"

    fill_in "Code", with: @procedure_category.code
    fill_in "Max appointment days", with: @procedure_category.max_appointment_days
    fill_in "Max postponment days", with: @procedure_category.max_postponment_days
    click_on "Create Procedure category"

    assert_text "Procedure category was successfully created"
    click_on "Back"
  end

  test "updating a Procedure category" do
    visit procedure_categories_url
    click_on "Edit", match: :first

    fill_in "Code", with: @procedure_category.code
    fill_in "Max appointment days", with: @procedure_category.max_appointment_days
    fill_in "Max postponment days", with: @procedure_category.max_postponment_days
    click_on "Update Procedure category"

    assert_text "Procedure category was successfully updated"
    click_on "Back"
  end

  test "destroying a Procedure category" do
    visit procedure_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Procedure category was successfully destroyed"
  end
end
