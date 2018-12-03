require 'test_helper'

class Day3Test < Test::Unit::TestCase # <- After modification
  def test_that_it_has_a_version_number
    refute_nil ::Day3::VERSION
  end

  def test_draw_sample
    overlap, _ = ::Day3::draw_sample
    assert_equal 4, overlap
  end

  def test_draw_data
    overlap, _ = ::Day3::draw_data
    assert_equal 113716, overlap
  end

  def test_draw_sample_not_overlapping
    _, id = ::Day3::draw_sample
    assert_equal 3, id
  end

  def test_draw_data_not_overlapping
    _, id = ::Day3::draw_data
    assert_equal 742, id
  end
end