#!/bin/ruby

module AsUnit
	CLASS_TEMPLATE = 'Class.erb'
	TEST_TEMPLATE = 'TestCase.erb'

  # ------------------------------------------------------------------
  # Rake module singleton methods.
  #
  class << self
    # Current Rake Application
    def application
      @application ||= AsUnit::Application.new
    end

    # Set the current Rake application object.
    def application=(app)
      @application = app
    end

    # Return the original directory where the Rake application was
    # started.
    def original_dir
      application.original_dir
    end

	####################################################################
	# Mixin for creating easily cloned objects.
	#
	module Cloneable
	# Clone an object by making a new object and setting all the
	# instance variables to the same values.
	    def clone
	      sibling = self.class.new
	      instance_variables.each do |ivar|
	        value = self.instance_variable_get(ivar)
	        sibling.instance_variable_set(ivar, value.rake_dup)
	      end
	      sibling
	    end
	    alias dup clone
	  end
  end

	require 'yaml'
	require 'optparse'
	require 'settings'
	require 'create_class'
	require 'asunit_arguments'
	
	class Application
		@@PROJECT_FILE_NAME = '.asunit'
		
		def initialize
			super
			arguments = AsUnitArguments.new(ARGV)
			project_file = get_project_file Dir.pwd
			prefs = YAML.load(project_file.read)
			settings = AsUnit::Settings.new(prefs)

			results = Array.new
			arguments.classnames.each { |name|
				if(name.ends_with? "Test")
					begin
						create_class(name, settings, TEST_TEMPLATE, arguments.force?)
					rescue Exception => e
						results.push(e)
					end
				else
					begin
						create_class(name, settings, AsUnit::CLASS_TEMPLATE, arguments.force?)
					rescue Exception => e
						results.push(e)
					end
					begin
						create_class(name + "Test", settings, AsUnit::TEST_TEMPLATE, arguments.force?)
					rescue Exception => e
						results.push(e)
					end
				end
			}
			if(results.length > 0)
				puts results.join("\n")
			end
		end
		
		def create_class(name, settings, template, force)
			begin
				class_creator = AsUnit::CreateClass.new(name, settings, template)
				class_creator.run(force)
				puts 'File Created at: ' + class_creator.final_path
				return nil
			rescue Exception => e
				raise e
			end
		end

		def get_project_file(dir)
			if(dir == '/')
				raise 'Project file not found, please create a new asunit project by typing "asunit -create-project [-src, -test, -templates]"'
			end
			Dir.chdir dir
			if(File.exists? @@PROJECT_FILE_NAME)
				return File.open(@@PROJECT_FILE_NAME, 'r')
			end
			get_project_file(File.dirname(dir))
		end
	end
	
end

class String
	def ends_with? str
		return false
	end
end

if __FILE__ == $0 then
  AsUnit::Application.new
end
