require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get messages_new_url
    assert_response :success
  end

  test "should get create" do
    get messages_create_url
    assert_response :success
  end

  test "should get index" do
    get messages_index_url
    assert_response :success
  end
end
