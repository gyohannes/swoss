require "application_system_test_case"

class AdmissionsTest < ApplicationSystemTestCase
  setup do
    @admission = admissions(:one)
  end

  test "visiting the index" do
    visit admissions_url
    assert_selector "h1", text: "Admissions"
  end

  test "creating a Admission" do
    visit admissions_url
    click_on "New Admission"

    fill_in "Admission date", with: @admission.admission_date
    fill_in "Admission type", with: @admission.admission_type
    fill_in "Appointment date", with: @admission.appointment_date
    fill_in "Department", with: @admission.department_id
    fill_in "Diagnosis", with: @admission.diagnosis_id
    fill_in "Listing status", with: @admission.listing_status
    fill_in "Patient", with: @admission.patient_id
    fill_in "Payment type", with: @admission.payment_type_id
    fill_in "Physician", with: @admission.physician_id
    check "Priority" if @admission.priority
    fill_in "Procedure", with: @admission.procedure_id
    fill_in "User", with: @admission.user_id
    fill_in "Ward", with: @admission.ward_id
    click_on "Create Admission"

    assert_text "Admission was successfully created"
    click_on "Back"
  end

  test "updating a Admission" do
    visit admissions_url
    click_on "Edit", match: :first

    fill_in "Admission date", with: @admission.admission_date
    fill_in "Admission type", with: @admission.admission_type
    fill_in "Appointment date", with: @admission.appointment_date
    fill_in "Department", with: @admission.department_id
    fill_in "Diagnosis", with: @admission.diagnosis_id
    fill_in "Listing status", with: @admission.listing_status
    fill_in "Patient", with: @admission.patient_id
    fill_in "Payment type", with: @admission.payment_type_id
    fill_in "Physician", with: @admission.physician_id
    check "Priority" if @admission.priority
    fill_in "Procedure", with: @admission.procedure_id
    fill_in "User", with: @admission.user_id
    fill_in "Ward", with: @admission.ward_id
    click_on "Update Admission"

    assert_text "Admission was successfully updated"
    click_on "Back"
  end

  test "destroying a Admission" do
    visit admissions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Admission was successfully destroyed"
  end
end
