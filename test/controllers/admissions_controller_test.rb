require 'test_helper'

class AdmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admission = admissions(:one)
  end

  test "should get index" do
    get admissions_url
    assert_response :success
  end

  test "should get new" do
    get new_admission_url
    assert_response :success
  end

  test "should create admission" do
    assert_difference('Admission.count') do
      post admissions_url, params: { admission: { admission_date: @admission.admission_date, admission_type: @admission.admission_type, appointment_date: @admission.appointment_date, department_id: @admission.department_id, diagnosis_id: @admission.diagnosis_id, listing_status: @admission.listing_status, patient_id: @admission.patient_id, payment_type_id: @admission.payment_type_id, physician_id: @admission.physician_id, priority: @admission.priority, procedure_id: @admission.procedure_id, user_id: @admission.user_id, ward_id: @admission.ward_id } }
    end

    assert_redirected_to admission_url(Admission.last)
  end

  test "should show admission" do
    get admission_url(@admission)
    assert_response :success
  end

  test "should get edit" do
    get edit_admission_url(@admission)
    assert_response :success
  end

  test "should update admission" do
    patch admission_url(@admission), params: { admission: { admission_date: @admission.admission_date, admission_type: @admission.admission_type, appointment_date: @admission.appointment_date, department_id: @admission.department_id, diagnosis_id: @admission.diagnosis_id, listing_status: @admission.listing_status, patient_id: @admission.patient_id, payment_type_id: @admission.payment_type_id, physician_id: @admission.physician_id, priority: @admission.priority, procedure_id: @admission.procedure_id, user_id: @admission.user_id, ward_id: @admission.ward_id } }
    assert_redirected_to admission_url(@admission)
  end

  test "should destroy admission" do
    assert_difference('Admission.count', -1) do
      delete admission_url(@admission)
    end

    assert_redirected_to admissions_url
  end
end
