#!/bin/ruby

require 'settings.rb'

module AsUnit
	#################################
	# Project Class
	#################################
	# Should be able to enter something like:
	# asunit project Lifebin
	# and get an auto-configured ready-to-go
	# actionscript project file, folders etc...
	# -src [source dir name]
	# -test [test dir name]
	# -path [colon-separated, space-escaped directory paths]
	# -lib [lib dir name]
	# -bin [binary dir name]

	class Project
		attr_reader :name, :settings
			
		def initialize(name, dir=nil)
			@name = name;
			@settings = AsUnit::Settings.new
			if(!dir.nil?)
				@dir = dir
			end
			content = create_dirs
			create_project_file('.asunit_' + name.downcase, content)
		end
		
		def create_dirs
			create_dir(@settings.src)
			create_dir(@settings.test)
			create_dir(@settings.lib)

			contents = ['src=\'' + File.expand_path(@settings.src) + '\'']
			contents.push('test=\'' + File.expand_path(@settings.test) + '\'')
			contents.push('lib=\'' + File.expand_path(@settings.lib) + '\'')
		end
		
		def create_project_file(name, contents)
			open(name, 'w') do |f|
				contents.each { |i|
					f.puts i
				}
				f.flush
			end
		end
		
		def dir
			if(@dir.nil?)
				@dir = Dir.pwd
			end
			@dir
		end
		
		def create_dir(name)
			# Don't overwrite existing dirs
			if(!File.exists? name)
				Dir.mkdir name
			end
			return File.new name
		end
		
	end
end