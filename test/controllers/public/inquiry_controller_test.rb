require 'test_helper'

class Public::InquiryControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_inquiry_new_url
    assert_response :success
  end

  test "should get confirm" do
    get public_inquiry_confirm_url
    assert_response :success
  end

  test "should get finish" do
    get public_inquiry_finish_url
    assert_response :success
  end

end
