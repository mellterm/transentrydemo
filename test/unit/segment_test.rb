require 'test_helper'

class SegmentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Segment.new.valid?
  end
end
