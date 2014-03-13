require 'test_helper'

class SpispiControllerTest < ActionController::TestCase
  def testTruth
    assert_equal "cont", SpispiController.new.cont
  end
  
  test "the truth" do
    assert true
  end
end
