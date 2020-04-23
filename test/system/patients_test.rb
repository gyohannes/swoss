require "application_system_test_case"

class PatientsTest < ApplicationSystemTestCase
  setup do
    @patient = patients(:one)
  end

  test "visiting the index" do
    visit patients_url
    assert_selector "h1", text: "Patients"
  end

  test "creating a Patient" do
    visit patients_url
    click_on "New Patient"

    fill_in "Mrn", with: @patient.MRN
    fill_in "Admission date", with: @patient.admission_date
    fill_in "Admission type", with: @patient.admission_type
    fill_in "Age", with: @patient.age
    fill_in "Appointment date", with: @patient.appointment_date
    fill_in "Contact person telephone number", with: @patient.contact_person_telephone_number
    fill_in "Date of birth", with: @patient.date_of_birth
    fill_in "Date of registration", with: @patient.date_of_registration
    fill_in "Department", with: @patient.department_id
    fill_in "Diagnosis", with: @patient.diagnosis_id
    fill_in "Father name", with: @patient.father_name
    fill_in "First name", with: @patient.first_name
    fill_in "Grand father name", with: @patient.grand_father_name
    fill_in "House number", with: @patient.house_number
    fill_in "Kebele", with: @patient.kebele
    fill_in "Listing status", with: @patient.listing_status
    fill_in "Name of contact person", with: @patient.name_of_contact_person
    fill_in "Payment type", with: @patient.payment_type_id
    fill_in "Physician", with: @patient.physician_id
    fill_in "Primary telephone number", with: @patient.primary_telephone_number
    check "Priority" if @patient.priority
    fill_in "Procedure", with: @patient.procedure_id
    fill_in "Region", with: @patient.region_id
    fill_in "Sex", with: @patient.sex
    fill_in "Ward", with: @patient.ward_id
    fill_in "Woreda", with: @patient.woreda
    fill_in "Zone", with: @patient.zone
    click_on "Create Patient"

    assert_text "Patient was successfully created"
    click_on "Back"
  end

  test "updating a Patient" do
    visit patients_url
    click_on "Edit", match: :first

    fill_in "Mrn", with: @patient.MRN
    fill_in "Admission date", with: @patient.admission_date
    fill_in "Admission type", with: @patient.admission_type
    fill_in "Age", with: @patient.age
    fill_in "Appointment date", with: @patient.appointment_date
    fill_in "Contact person telephone number", with: @patient.contact_person_telephone_number
    fill_in "Date of birth", with: @patient.date_of_birth
    fill_in "Date of registration", with: @patient.date_of_registration
    fill_in "Department", with: @patient.department_id
    fill_in "Diagnosis", with: @patient.diagnosis_id
    fill_in "Father name", with: @patient.father_name
    fill_in "First name", with: @patient.first_name
    fill_in "Grand father name", with: @patient.grand_father_name
    fill_in "House number", with: @patient.house_number
    fill_in "Kebele", with: @patient.kebele
    fill_in "Listing status", with: @patient.listing_status
    fill_in "Name of contact person", with: @patient.name_of_contact_person
    fill_in "Payment type", with: @patient.payment_type_id
    fill_in "Physician", with: @patient.physician_id
    fill_in "Primary telephone number", with: @patient.primary_telephone_number
    check "Priority" if @patient.priority
    fill_in "Procedure", with: @patient.procedure_id
    fill_in "Region", with: @patient.region_id
    fill_in "Sex", with: @patient.sex
    fill_in "Ward", with: @patient.ward_id
    fill_in "Woreda", with: @patient.woreda
    fill_in "Zone", with: @patient.zone
    click_on "Update Patient"

    assert_text "Patient was successfully updated"
    click_on "Back"
  end

  test "destroying a Patient" do
    visit patients_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Patient was successfully destroyed"
  end
end
