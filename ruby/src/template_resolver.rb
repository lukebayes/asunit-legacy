
require 'settings'
require 'erb'

module AsUnit
	class TemplateResolver
		attr_reader :template, :fullclass, :interfaces, :test_cases
		attr_accessor :superclass, :display_object
		
		def initialize(fullclass)
			@fullclass = fullclass;
			@classname = fullclass.split('.').pop
			@template = template
			@package = nil
			@parsed = nil
			@superclass = nil
			@display_object = false
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
		
		def classname(fullname=@classname)
			return fullname.split('.').pop
		end

		def package(pkg=@package)
			if(pkg.nil?)
				segments = fullclass.split('.')
				segments.pop
				pkg = segments.join('.')
				if(segments.length > 0)
					pkg += ' '
				end
			end
			return pkg
		end
		
		def path
			return fullclass.split('.').join(File::SEPARATOR)	
		end

		def add_test_case(test_case)
			@test_cases.push(test_case)
			@test_cases.sort!
		end
		
		def class_under_test
			return classname.sub(/Test$/, '')
		end

		def display_object?
			return @display_object
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
		
		def superclass_decl
			if(superclass?)
				return ' extends ' + superclass.split('.').pop
			else
				return ''
			end
		end
		
		def import_statements
			imports = Array.new
			if(superclass?)
				imports.push(import_statement(superclass))
			end
			if(interfaces?)
				interfaces.each {|inf|
					imports.push(import_statement(inf))
				}
			end
			if(imports.length == 0)
				return ''
			end
			imports.sort!
			return "\n" + imports.join("\n") + "\n"
		end
		
		def import_statement(target)
			return "\timport " + target + ";"
		end
		
		def interfaces_decl
			if(!interfaces?)
				return ''
			end
			infs = Array.new
			interfaces.each {|inf|
				infs.push(classname(inf))
			}
			return " implements " + infs.join(", ")
		end
	end
end
