require 'test_helper'

class SensorrTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sensorr::VERSION
  end

  def test_that_it_responds_to_sources
    assert ::Sensorr.respond_to?(:sources)
    assert ::Sensorr.sources.kind_of?(Array)
  end

  def test_that_it_allows_sources_manipulation
    # Add a source
    source = Object.new
    Sensorr.push(source)
    assert_equal [source], Sensorr.sources

    # Remove the source
    assert_equal source, Sensorr.sources.pop
    assert_equal [], Sensorr.sources
  end

end
