require 'test_helper'

class Day4Test < Test::Unit::TestCase # <- After modification
  def test_that_it_has_a_version_number
    refute_nil ::Day4::VERSION
  end

  def test_guard_sample
    assert_equal [240, 4455], ::Day4::guard_sample
  end

  def test_guard_data
    assert_equal [109659, 36371], ::Day4::guard_data
  end
end