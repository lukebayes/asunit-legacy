
require 'test/unit'
require 'create_class.rb'

class CreateClassTest < Test::Unit::TestCase

	def setup
		@instance = AsUnit::CreateClass.new
	end
	
	def teardown
		@instance = nil
	end
	
	def test_instantiated
		assert(!@instance.nil?)
	end
end