#!/bin/ruby

module AsUnit
	CLASS_TEMPLATE = 'Class.erb'
	TEST_TEMPLATE = 'TestCase.erb'
	PROJECT_FILE_NAME = '.asunit'

	require 'yaml'
	require 'optparse'
	require 'settings'
	require 'create_class'
	require 'asunit_arguments'
	
	class Application
		
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
						create_class(name, settings, TEST_TEMPLATE, arguments)
					rescue Exception => e
						results.push(e)
					end
				else
					begin
						create_class(name, settings, AsUnit::CLASS_TEMPLATE, arguments)
					rescue Exception => e
						results.push(e)
					end
					begin
						create_class(name + "Test", settings, AsUnit::TEST_TEMPLATE, arguments)
					rescue Exception => e
						results.push(e)
					end
				end
			}
			if(results.length > 0)
				puts results.join("\n")
			end
		end
		
		def create_class(name, settings, template, arguments)
			begin
				class_creator = AsUnit::CreateClass.new(name, settings, template)
				class_creator.run(arguments)
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
			if(File.exists? AsUnit::PROJECT_FILE_NAME)
				return File.open(AsUnit::PROJECT_FILE_NAME, 'r')
			end
			get_project_file(File.dirname(dir))
		end
	end	
end
