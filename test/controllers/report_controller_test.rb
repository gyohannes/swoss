require 'test_helper'

class ReportControllerTest < ActionDispatch::IntegrationTest
  test "should get backlog" do
    get report_backlog_url
    assert_response :success
  end

  test "should get waitlist" do
    get report_waitlist_url
    assert_response :success
  end

  test "should get sergical_service" do
    get report_sergical_service_url
    assert_response :success
  end

  test "should get sergical_service_efficiency" do
    get report_sergical_service_efficiency_url
    assert_response :success
  end

  test "should get surgical_efficiency" do
    get report_surgical_efficiency_url
    assert_response :success
  end

end
