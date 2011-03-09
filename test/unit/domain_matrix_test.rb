require 'test_helper'

class DomainMatrixTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert DomainMatrix.new.valid?
  end
end
