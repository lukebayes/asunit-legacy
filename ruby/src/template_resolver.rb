
require 'settings'
require 'erb'

module AsUnit
	class TemplateResolver
		attr_reader :template, :fullclass, :classname, :interfaces, :test_cases
		attr_accessor :superclass, :visual
		
		def initialize(fullclass)
			@fullclass = fullclass;
			@classname = fullclass.split('.').pop
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
				segments = fullclass.split('.')
				segments.pop
				@package = segments.join('.')
				if(segments.length > 0)
					@package += ' '
				end
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
