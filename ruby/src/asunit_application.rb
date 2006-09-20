#!/bin/ruby

module AsUnit
	CLASS_TEMPLATE = 'Class.erb'
	TEST_TEMPLATE = 'TestCase.erb'
	PROJECT_FILE_NAME = '.asunit'
	FLEX_PROJECT_FILE_NAME = '.actionScriptProperties'

	require 'yaml'
	require 'optparse'
	require 'settings'
	require 'create_class'
	require 'asunit_arguments'
	
	class Application
		
		def initialize
			super
			arguments = AsUnitArguments.new(ARGV)
			@starting_dir = Dir.pwd
			project_file = get_project_file(Dir.pwd, AsUnit::PROJECT_FILE_NAME)
			if(project_file.nil?)
				Dir.chdir @starting_dir
				project_file = get_project_file(Dir.pwd, AsUnit::PROJECT_FILE_NAME)
			end

			if(project_file.nil?)
				puts 'No project file found!'
			end

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

		def get_project_file(dir, project_file_name)
			if(dir == '/')
				return nil
#				raise 'Project file not found, please create a new asunit project by typing "asunit -create-project [-src, -test, -templates]"'
			end
			Dir.chdir dir
			if(File.exists? project_file_name)
				return File.open(project_file_name, 'r')
			end
			get_project_file(File.dirname(dir), project_file_name)
		end
	end	
end
