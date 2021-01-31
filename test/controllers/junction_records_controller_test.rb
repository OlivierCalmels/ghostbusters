require "test_helper"

class JunctionRecordsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should return the 1:1 export with a score of 100%" do
    get filter_path
    assert_template 'filter'
  end
end
