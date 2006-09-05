
require 'test/unit'
require 'createclass.rb'
require 'erb'

class CreateClassTest < Test::Unit::TestCase
	
	def setup
		@full_class_name = "org.somepackage.SomeClass"
		@instance = AsUnit::CreateClass.new(@full_class_name, get_erb)
		@instance2 = AsUnit::CreateClass.new('SomeClass', get_erb)
	end
	
	def teardown
		@instance = nil
	end

	def get_erb
		template = %q{
			package <%= package %> {
				class <%= @classname %><% %> {
					import asunit.framework.TestCase
				}
			}
		}
	end
	
	def test_instantiated
		assert_not_nil(@instance)
	end
	
	def test_class_name
		assert_equal(@instance.classname, @full_class_name)
	end
	
	def test_package
		assert_equal(@instance.package, 'org.somepackage')
		assert_equal(@instance2.package, '')
	end
	
end