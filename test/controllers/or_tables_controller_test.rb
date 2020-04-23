require 'test_helper'

class OrTablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @or_table = or_tables(:one)
  end

  test "should get index" do
    get or_tables_url
    assert_response :success
  end

  test "should get new" do
    get new_or_table_url
    assert_response :success
  end

  test "should create or_table" do
    assert_difference('OrTable.count') do
      post or_tables_url, params: { or_table: { code: @or_table.code, hospital_id: @or_table.hospital_id, name: @or_table.name } }
    end

    assert_redirected_to or_table_url(OrTable.last)
  end

  test "should show or_table" do
    get or_table_url(@or_table)
    assert_response :success
  end

  test "should get edit" do
    get edit_or_table_url(@or_table)
    assert_response :success
  end

  test "should update or_table" do
    patch or_table_url(@or_table), params: { or_table: { code: @or_table.code, hospital_id: @or_table.hospital_id, name: @or_table.name } }
    assert_redirected_to or_table_url(@or_table)
  end

  test "should destroy or_table" do
    assert_difference('OrTable.count', -1) do
      delete or_table_url(@or_table)
    end

    assert_redirected_to or_tables_url
  end
end
