#!/bin/ruby

require 'test/unit'
require 'project.rb'
require 'settings.rb'

class ProjectTest < Test::Unit::TestCase

	def setup
		@default_name = 'Lifebin'
		@instance = AsUnit::Project.new @default_name
	end
	
	def test_instantiated
		assert_not_nil(@instance)
	end
	
	def test_name
		assert_equal(@instance.name, @default_name)
	end
end
