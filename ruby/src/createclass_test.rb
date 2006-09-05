
require 'test/unit'
require 'createclass.rb'

class CreateClassTest < Test::Unit::TestCase
	
	def setup
		@full_class_name = "org.asunit.SomeClass"
		@instance = AsUnit::CreateClass.new @full_class_name
	end

	def test_instantiated
		assert_not_nil(@instance)
	end
	
	def test_class_name
		assert(@instance.full_class_name == @full_class_name)
	end
	
end