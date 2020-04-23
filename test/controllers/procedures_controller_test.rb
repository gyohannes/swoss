require 'test_helper'

class ProceduresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @procedure = procedures(:one)
  end

  test "should get index" do
    get procedures_url
    assert_response :success
  end

  test "should get new" do
    get new_procedure_url
    assert_response :success
  end

  test "should create procedure" do
    assert_difference('Procedure.count') do
      post procedures_url, params: { procedure: { category: @procedure.category, max_appointment_days: @procedure.max_appointment_days, max_postponment_days: @procedure.max_postponment_days, name: @procedure.name } }
    end

    assert_redirected_to procedure_url(Procedure.last)
  end

  test "should show procedure" do
    get procedure_url(@procedure)
    assert_response :success
  end

  test "should get edit" do
    get edit_procedure_url(@procedure)
    assert_response :success
  end

  test "should update procedure" do
    patch procedure_url(@procedure), params: { procedure: { category: @procedure.category, max_appointment_days: @procedure.max_appointment_days, max_postponment_days: @procedure.max_postponment_days, name: @procedure.name } }
    assert_redirected_to procedure_url(@procedure)
  end

  test "should destroy procedure" do
    assert_difference('Procedure.count', -1) do
      delete procedure_url(@procedure)
    end

    assert_redirected_to procedures_url
  end
end
