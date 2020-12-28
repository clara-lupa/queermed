require "test_helper"

class ProvidersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get providers_index_url
    assert_response :success
  end

  test "should get show" do
    get providers_show_url
    assert_response :success
  end
end
