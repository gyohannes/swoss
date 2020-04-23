require 'test_helper'

class PatientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patient = patients(:one)
  end

  test "should get index" do
    get patients_url
    assert_response :success
  end

  test "should get new" do
    get new_patient_url
    assert_response :success
  end

  test "should create patient" do
    assert_difference('Patient.count') do
      post patients_url, params: { patient: { MRN: @patient.MRN, admission_date: @patient.admission_date, admission_type: @patient.admission_type, age: @patient.age, appointment_date: @patient.appointment_date, contact_person_telephone_number: @patient.contact_person_telephone_number, date_of_birth: @patient.date_of_birth, date_of_registration: @patient.date_of_registration, department_id: @patient.department_id, diagnosis_id: @patient.diagnosis_id, father_name: @patient.father_name, first_name: @patient.first_name, grand_father_name: @patient.grand_father_name, house_number: @patient.house_number, kebele: @patient.kebele, listing_status: @patient.listing_status, name_of_contact_person: @patient.name_of_contact_person, payment_type_id: @patient.payment_type_id, physician_id: @patient.physician_id, primary_telephone_number: @patient.primary_telephone_number, priority: @patient.priority, procedure_id: @patient.procedure_id, region_id: @patient.region_id, sex: @patient.sex, ward_id: @patient.ward_id, woreda: @patient.woreda, zone: @patient.zone } }
    end

    assert_redirected_to patient_url(Patient.last)
  end

  test "should show patient" do
    get patient_url(@patient)
    assert_response :success
  end

  test "should get edit" do
    get edit_patient_url(@patient)
    assert_response :success
  end

  test "should update patient" do
    patch patient_url(@patient), params: { patient: { MRN: @patient.MRN, admission_date: @patient.admission_date, admission_type: @patient.admission_type, age: @patient.age, appointment_date: @patient.appointment_date, contact_person_telephone_number: @patient.contact_person_telephone_number, date_of_birth: @patient.date_of_birth, date_of_registration: @patient.date_of_registration, department_id: @patient.department_id, diagnosis_id: @patient.diagnosis_id, father_name: @patient.father_name, first_name: @patient.first_name, grand_father_name: @patient.grand_father_name, house_number: @patient.house_number, kebele: @patient.kebele, listing_status: @patient.listing_status, name_of_contact_person: @patient.name_of_contact_person, payment_type_id: @patient.payment_type_id, physician_id: @patient.physician_id, primary_telephone_number: @patient.primary_telephone_number, priority: @patient.priority, procedure_id: @patient.procedure_id, region_id: @patient.region_id, sex: @patient.sex, ward_id: @patient.ward_id, woreda: @patient.woreda, zone: @patient.zone } }
    assert_redirected_to patient_url(@patient)
  end

  test "should destroy patient" do
    assert_difference('Patient.count', -1) do
      delete patient_url(@patient)
    end

    assert_redirected_to patients_url
  end
end
