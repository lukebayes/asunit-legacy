
require 'test/unit'
require 'create_class'
require 'settings'

class CreateClassTest < Test::Unit::TestCase

	def setup
		@classname = 'somepackage.otherpackage.SomeClass'
		@template_name = 'Class.erb'
		@settings = AsUnit::Settings.new
		@instance = AsUnit::CreateClass.new(@classname, @settings, @template_name)
	end
	
	def teardown
		@instance = nil
	end
	
	def test_instantiated
		assert(!@instance.nil?)
	end
	
	def test_templates
		@instance.settings = AsUnit::Settings.new
		assert(!@instance.nil?)
	end
	
	def test_template
		assert_equal(@template_name, @instance.template_name)
	end
	
	def test_run
		@instance.run
	end
end