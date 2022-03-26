require "test_helper"

class InvatationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get invatation_index_url
    assert_response :success
  end
end
