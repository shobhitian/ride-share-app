require "test_helper"

class UserImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_images_create_url
    assert_response :success
  end
end
