# frozen_string_literal: true

require 'minitest/autorun'
require 'kapellmeister'

class DeepCompactTest < Minitest::Test
  def test_preserves_false_in_nested_hashes
    check_box = {
      paid: false,
      is_original: false,
      took_doc: false,
      micro_loan: false,
      less_50: false
    }

    assert_equal check_box, check_box.deep_compact
    assert_equal({ check_box: check_box }, { check_box: check_box }.deep_compact!)
  end

  def test_still_removes_nil_values
    assert_equal({ name: 'School' }, { guid: nil, name: 'School' }.deep_compact)
  end
end
