require "application_system_test_case"

class ScheduleOrdersTest < ApplicationSystemTestCase
  setup do
    @schedule_order = schedule_orders(:one)
  end

  test "visiting the index" do
    visit schedule_orders_url
    assert_selector "h1", text: "Schedule Orders"
  end

  test "creating a Schedule order" do
    visit schedule_orders_url
    click_on "New Schedule Order"

    fill_in "Name", with: @schedule_order.name
    click_on "Create Schedule order"

    assert_text "Schedule order was successfully created"
    click_on "Back"
  end

  test "updating a Schedule order" do
    visit schedule_orders_url
    click_on "Edit", match: :first

    fill_in "Name", with: @schedule_order.name
    click_on "Update Schedule order"

    assert_text "Schedule order was successfully updated"
    click_on "Back"
  end

  test "destroying a Schedule order" do
    visit schedule_orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Schedule order was successfully destroyed"
  end
end
