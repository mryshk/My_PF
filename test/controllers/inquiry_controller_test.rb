require 'test_helper'

class InquiryControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get inquiry_new_url
    assert_response :success
  end

  test "should get confirm" do
    get inquiry_confirm_url
    assert_response :success
  end

  test "should get finish" do
    get inquiry_finish_url
    assert_response :success
  end

end
