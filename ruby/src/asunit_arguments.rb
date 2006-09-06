
require 'optparse'

module AsUnit
	class AsUnitArguments < Hash
	    
	    def initialize(args)
	      super
	      self[:classnames] = nil
	      self[:display_object] = false
	      self[:force] = false
	      self[:interfaces] = Array.new
	      self[:project_file] = nil
	      self[:superclass] = nil
	      
	      opts = OptionParser.new do |opts|
	      	opts.banner = "Usage: #$0 [options] CLASSNAME(s)"

			opts.on('-d', '--display-object', 'class is a visual entity') do
				self[:display_object] = true
			end
			
			opts.on('-f', '--force', 'force overwrite even if files exist') do
				self[:force] = true
			end
			
	      	opts.on('-i', '--add-interface [STRING]', 'add an interface to this class [STRING]') do |inf|
	      		if(inf.nil?)
	      			raise '-i [--add-interface] argument must be followed by a fully-qualified interface name eg: "flash.events.IEventDispatcher"'
	      		end
	      		self[:interfaces].push(inf || '$')
	      	end
	      	
	      	opts.on('-p', '--project-file [FILE]', 'use provided project file [FILE]') do |file|
	      		if(file.nil?)
	      			raise '-p [--project-file] argument must be followed by a relative or absolute file target"'
	      		end
	      		self[:project_file] = (file || '$')
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
		
		def display_object?
			return self[:display_object]
		end
		
		def force?
			return self[:force]
		end
	end
end