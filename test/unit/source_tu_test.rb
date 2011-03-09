require 'test_helper'

class SourceTuTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert SourceTu.new.valid?
  end
end
