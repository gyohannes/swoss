require 'test_helper'

class ScheduleOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @schedule_order = schedule_orders(:one)
  end

  test "should get index" do
    get schedule_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_schedule_order_url
    assert_response :success
  end

  test "should create schedule_order" do
    assert_difference('ScheduleOrder.count') do
      post schedule_orders_url, params: { schedule_order: { name: @schedule_order.name } }
    end

    assert_redirected_to schedule_order_url(ScheduleOrder.last)
  end

  test "should show schedule_order" do
    get schedule_order_url(@schedule_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_schedule_order_url(@schedule_order)
    assert_response :success
  end

  test "should update schedule_order" do
    patch schedule_order_url(@schedule_order), params: { schedule_order: { name: @schedule_order.name } }
    assert_redirected_to schedule_order_url(@schedule_order)
  end

  test "should destroy schedule_order" do
    assert_difference('ScheduleOrder.count', -1) do
      delete schedule_order_url(@schedule_order)
    end

    assert_redirected_to schedule_orders_url
  end
end
