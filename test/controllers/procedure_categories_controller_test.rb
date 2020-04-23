require 'test_helper'

class ProcedureCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @procedure_category = procedure_categories(:one)
  end

  test "should get index" do
    get procedure_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_procedure_category_url
    assert_response :success
  end

  test "should create procedure_category" do
    assert_difference('ProcedureCategory.count') do
      post procedure_categories_url, params: { procedure_category: { code: @procedure_category.code, max_appointment_days: @procedure_category.max_appointment_days, max_postponment_days: @procedure_category.max_postponment_days } }
    end

    assert_redirected_to procedure_category_url(ProcedureCategory.last)
  end

  test "should show procedure_category" do
    get procedure_category_url(@procedure_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_procedure_category_url(@procedure_category)
    assert_response :success
  end

  test "should update procedure_category" do
    patch procedure_category_url(@procedure_category), params: { procedure_category: { code: @procedure_category.code, max_appointment_days: @procedure_category.max_appointment_days, max_postponment_days: @procedure_category.max_postponment_days } }
    assert_redirected_to procedure_category_url(@procedure_category)
  end

  test "should destroy procedure_category" do
    assert_difference('ProcedureCategory.count', -1) do
      delete procedure_category_url(@procedure_category)
    end

    assert_redirected_to procedure_categories_url
  end
end
