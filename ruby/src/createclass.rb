
require 'settings'

module AsUnit
	class CreateClass
		attr_reader :classname
		attr_accessor :extends, :visual
		
		def initialize(name, template)
			@classname = name;
			@template = template
			@package = nil
			@parsed = nil
			@extends = nil
			@implements = nil
			@visual = nil
		end
		
		def parsed
			if(@parsed.nil?)
				@parsed = ERB.new(@template).result(binding)
			end
			@parsed
		end
		
		def package
			if(@package.nil?)
				arr = classname.split('.')
				arr.pop
				@package = arr.join('.')
			end
			return @package
		end
		
		def extends?
			return @extends.nil?
		end
		
		def implements?
			return @implements.nil?
		end
		
		def implements=(interface)
			if(@implements.nil?)
				@implements = Array.new
			end
			@implements.push(interface)
		end
		
		def implements
			@implements
		end
		
		def visual?
			return @visual.nil?
		end
	end
end
