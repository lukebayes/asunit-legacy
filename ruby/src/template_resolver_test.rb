
require 'test/unit'
require 'template_resolver.rb'

class TemplateResolverTest < Test::Unit::TestCase
	
	def setup
		@full_class_name = "org.somepackage.SomeClass"
		@instance = AsUnit::TemplateResolver.new(@full_class_name)
	end
	
	def teardown
		@instance = nil
	end

	def test_instantiated
		assert_not_nil(@instance)
	end
	
	def test_class_name
		assert_equal(@instance.classname, @full_class_name)
	end
	
	def test_package
		assert_equal(@instance.package, 'org.somepackage')
	end
	
	def test_template
		@instance.template = 'foo'
		result = @instance.parse
		assert_equal(result, 'foo')
	end
	
	def test_parse_superclass
		@instance.superclass = 'SomeClass'
		@instance.template = 'foo <%= superclass %>'
		assert_equal('foo SomeClass', @instance.parse)
	end

	def test_parse_interfaces
		@instance.add_interface 'b-one'
		@instance.add_interface 'a-two' # auto-sorted
		@instance.template = 'foo <%= interfaces[0] %>'	
		assert_equal('foo a-two', @instance.parse)
	end
	
	def test_parse_test_case
		@instance.add_test_case 'b-one'
		@instance.add_test_case 'a-two' # auto-sorted
		@instance.template = 'foo <%= test_cases[0] %>'
		assert_equal('foo a-two', @instance.parse)
	end
	
	def test_visual
		assert(!@instance.visual)
		@instance.visual = true
		assert(@instance.visual)
	end

	def test_add_test_case
		assert_equal(@instance.test_cases.length, 0);
		tc = 'asunit.framework.TestCaseTest'
		@instance.add_test_case tc
		assert_equal(tc, @instance.test_cases[0]);
		tc2 = 'asunit.framework.AssertTest'
		@instance.add_test_case tc2
		assert_equal(tc2, @instance.test_cases[0]);
		assert_equal(tc, @instance.test_cases[1]);
	end
	
	def test_interfaces
		impl = 'asunit.framework.IControl'
		assert(!@instance.interfaces?)
		@instance.add_interface impl
		assert_equal(impl, @instance.interfaces[0])
		assert(@instance.interfaces?)
		impl2 = 'asunit.framework.Layoutable'
		@instance.add_interface impl2
		assert_equal(impl, @instance.interfaces[0])
		assert_equal(impl2, @instance.interfaces[1])
	end
	
	def test_superclass
		assert(!@instance.superclass?) 
		sc = 'flash.display.DisplayObject'
		@instance.superclass = sc
		assert_equal(sc, @instance.superclass)
	end
end