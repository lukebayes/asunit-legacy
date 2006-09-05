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
		def initialize
			super
			arguments = AsUnitArguments.new(ARGV)
	    	counter = 0
	    	eol = 
	    	ARGF.each do |line|
	    		line.sub!(/$/, arguments[:show_ends])
	    		print '%6.d  ' % (counter += 1) if arguments[:number_lines]
	    		print line
			end
		end
	end
	
	class AsUnitArguments < Hash
	    def initialize(args)
	      super
	      self[:show_ends] = ''
	      self[:number_lines] = false
	      
	      opts = OptionParser.new do |opts|
	      	opts.banner = "Usage: #$0 [options]"
	      	opts.on('-E', '--show-ends [STRING]',
	      			'display [STRING] at end of each line') do |string|
	      		self[:show_ends] = string || '$'
	      	end
	      	
	      	opts.on('-n', '--number', 'number all output lines') do
	      		self[:number_lines] = true
	      	end
	      	
	      	opts.on_tail('-h', '--help', 'display this help and exit') do
	      		puts opts
	      		exit
	      	end
	      	opts.parse!(args)
	      	
	      end
	    end
	end
end

if __FILE__ == $0 then
  AsUnit::Application.new
end
