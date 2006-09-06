#!/bin/ruby

module AsUnit
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

	require 'optparse'
	
	class Application
		@@PROJECT_FILE_NAME = '.asunit'

		def initialize
			super
			arguments = AsUnitArguments.new(ARGV)
			project_file = get_project_file Dir.pwd
			puts 'pf dir: ' + Dir.pwd
			puts 'pf: ' + project_file.read
			arguments.classnames.each { |name|
				create_class name
			}
		end
		
		def get_project_file(dir)
			if(dir == '/')
				raise 'Project file not found, please create a new asunit project by typing "asunit -create-project ProjectName"'
			end
			Dir.chdir dir
			if(File.exists? @@PROJECT_FILE_NAME)
				return File.open(@@PROJECT_FILE_NAME, 'r')
			end
			get_project_file(File.dirname dir)
		end

		def create_class(name)
			puts 'name: ' + name
		end
	end
	
	class AsUnitArguments < Hash
	    
	    def initialize(args)
	      super
	      self[:classnames] = nil
	      self[:display_object] = false
	      self[:interfaces] = Array.new
	      self[:project_file] = nil
	      self[:superclass] = nil
	      
	      opts = OptionParser.new do |opts|
	      	opts.banner = "Usage: #$0 [options] CLASSNAME(s)"

			opts.on('-d', '--display-object', 'class created is a subclass of flash.display.DisplayObject') do
				self[:display_object] = true
			end
			
	      	opts.on('-p', '--project-file [FILE]', 'use this project file instead of looking for the nearest one [FILE]') do |file|
	      		if(file.nil?)
	      			raise '-p [--project-file] argument must be followed by a relative or absolute file target"'
	      		end
	      		self[:project_file] = (file || '$')
	      	end
	      		      	
	      	opts.on('-i', '--add-interface [STRING]', 'add an interface to this class [STRING]') do |inf|
	      		if(inf.nil?)
	      			raise '-i [--add-interface] argument must be followed by a fully-qualified interface name eg: "flash.events.IEventDispatcher"'
	      		end
	      		self[:interfaces].push(inf || '$')
	      	end
	      	
	      	opts.on('-s', '--superclass [STRING]', 'superclass of class being created [STRING]') do |superclass|
	      		if(superclass.nil?)
	      			raise '-s [--superclass] argument must be followed by a fully-qualified class name eg: "flash.display.DisplayObject"'
	      		end
	      		self[:superclass] = (superclass || '$')
	      	end
	      	
	      	opts.on_tail('-h', '--help', 'display this help and exit') do
	      		puts opts
	      		exit
	      	end

			if(args.length == 0)
				puts opts
				exit
			end

	      	opts.parse!(args)
	      	self[:classnames] = args

	      end
	    end
		
		def project_file
			return self[:project_file]
		end

		def interfaces
			return self[:interfaces]
		end
		
		def superclass
			return self[:superclass]
		end
		
		def classnames
			return self[:classnames]
		end
	end
end

if __FILE__ == $0 then
  AsUnit::Application.new
end
