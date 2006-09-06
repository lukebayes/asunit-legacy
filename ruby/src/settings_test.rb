
require 'test/unit'
require 'settings.rb'

class SettingsTest < Test::Unit::TestCase

	def setup
		@instance = AsUnit::Settings.new
	end
	
	def test_instantiated
		assert_not_nil(@instance)
	end
end