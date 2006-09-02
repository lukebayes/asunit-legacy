#!/usr/bin/env ruby

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

	class Application
	    def initialize
	      super
	    end
	    
	    def run
	    	printf "Hello Nancy"
	    end
	end
end

if __FILE__ == $0 then
  AsUnit::Application.new.run
end
