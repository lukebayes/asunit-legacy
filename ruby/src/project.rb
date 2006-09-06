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
			if(!dir.nil?)
				puts 'changing working directory to : ' + dir
				Dir.chdir dir
			end

			dirs = AsUnit::Settings.new.directories
			content = create_dirs(dirs)
			create_project_file('.asunit', content)
		end
		
		def create_dirs(dirs)
			contents = Array.new
			dirs.each do |dir|
				create_dir(dir)
				contents.push("#{dir}=\'#{File.expand_path(dir)}\'")
			end
			contents
		end
		
		def create_project_file(name, contents)
			open(name, 'w') do |f|
				f.puts 'project=\'' + @name + '\''
				contents.each { |i|
					f.puts i
				}
				f.puts 'classpath=' + get_classpath
				f.flush
			end
		end
		
		def get_classpath
			return '\'\''
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
			return File.new(name)
		end		
	end
end