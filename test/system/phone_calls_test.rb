require "application_system_test_case"

class PhoneCallsTest < ApplicationSystemTestCase
  setup do
    @phone_call = phone_calls(:one)
  end

  test "visiting the index" do
    visit phone_calls_url
    assert_selector "h1", text: "Phone Calls"
  end

  test "creating a Phone call" do
    visit phone_calls_url
    click_on "New Phone Call"

    fill_in "Action", with: @phone_call.action
    fill_in "Admission", with: @phone_call.admission_id
    fill_in "Information", with: @phone_call.information
    fill_in "New appointment", with: @phone_call.new_appointment
    fill_in "Patient response", with: @phone_call.patient_response
    click_on "Create Phone call"

    assert_text "Phone call was successfully created"
    click_on "Back"
  end

  test "updating a Phone call" do
    visit phone_calls_url
    click_on "Edit", match: :first

    fill_in "Action", with: @phone_call.action
    fill_in "Admission", with: @phone_call.admission_id
    fill_in "Information", with: @phone_call.information
    fill_in "New appointment", with: @phone_call.new_appointment
    fill_in "Patient response", with: @phone_call.patient_response
    click_on "Update Phone call"

    assert_text "Phone call was successfully updated"
    click_on "Back"
  end

  test "destroying a Phone call" do
    visit phone_calls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Phone call was successfully destroyed"
  end
end
