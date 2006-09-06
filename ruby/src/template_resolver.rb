
require 'settings'
require 'erb'

module AsUnit
	class TemplateResolver
		attr_reader :template, :classname, :interfaces, :test_cases
		attr_accessor :superclass, :visual
		
		def initialize(name)
			@classname = name;
			@template = template
			@package = nil
			@parsed = nil
			@superclass = nil
			@visual = nil
			@interfaces = Array.new
			@test_cases = Array.new
		end
		
		def template=(template)
			@template = template
			@parsed = nil	
		end

		def parse
			return ERB.new(@template).result(binding)
		end
		
		def package
			if(@package.nil?)
				arr = classname.split('.')
				arr.pop
				@package = arr.join('.')
			end
			return @package
		end
		
		def add_test_case(test_case)
			@test_cases.push(test_case)
			@test_cases.sort!
		end

		def superclass?
			return !@superclass.nil?
		end
				
		def interfaces?
			return (@interfaces.length > 0)
		end
		
		def add_interface(interface)
			@interfaces.push(interface)
			@interfaces.sort!
		end
		
		def visual?
			return @visual.nil?
		end
	end
end
