require 'test_helper'

class TargetTuTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert TargetTu.new.valid?
  end
end
