require 'test_helper'

class Day2Test < Test::Unit::TestCase # <- After modification
  def test_that_it_has_a_version_number
    refute_nil ::Day2::VERSION
  end

  def test_sample
    assert_equal 12, ::Day2::sample
  end

  def test_data
    assert_equal 6000, ::Day2::data
  end

  def test_levenshtein_distance
    assert_equal 1, ::Day2::levenshtein_distance("ab", "aa")
  end

  def test_common_sample
    assert_equal "fgij", ::Day2::common_sample
  end

  def test_common_data
    assert_equal "pbykrmjmizwhxlqnasfgtycdv", ::Day2::common_data
  end
end