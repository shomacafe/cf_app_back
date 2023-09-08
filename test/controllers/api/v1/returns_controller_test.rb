require "test_helper"

class Api::V1::ReturnsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_returns_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_returns_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_returns_destroy_url
    assert_response :success
  end
end
