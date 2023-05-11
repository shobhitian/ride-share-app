require "test_helper"

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get vehicles_create_url
    assert_response :success
  end
end
