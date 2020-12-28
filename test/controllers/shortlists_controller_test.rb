require "test_helper"

class ShortlistsControllerTest < ActionDispatch::IntegrationTest
  test "should get create_shortlist" do
    get shortlists_create_shortlist_url
    assert_response :success
  end

  test "should get destroy_shortlist" do
    get shortlists_destroy_shortlist_url
    assert_response :success
  end
end
