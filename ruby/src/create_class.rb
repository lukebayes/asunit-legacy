
require 'template_resolver'

module AsUnit
	class CreateClass
		attr_accessor :settings, :template_name
		attr_reader :final_path, :resolver

		def initialize(name, settings, template)
			@settings = settings
			@template_name = template
			@resolver = AsUnit::TemplateResolver.new name
			@final_path = ''
		end
		
		def run(args)
			@resolver.superclass = args.superclass
			@resolver.display_object = args.display_object?
			args.interfaces.each {|inf|
				@resolver.add_interface(inf)
			}
			src = Dir.pwd + File::SEPARATOR + settings.templates + File::SEPARATOR + template_name
			template = IO.read(src)
			@resolver.template = template
			parsed = @resolver.parse
			file = create_file(target_file(settings.src), args.force?)
			file.write(parsed)
		end
		
		def create_file(relative, force)
			segments = relative.split(File::SEPARATOR)
			file_name = segments.pop
			current_path = ''
			segments.each { |dir|
				current_path << dir << File::SEPARATOR 
				if(!File.exists?(current_path))
					Dir.mkdir(current_path)
				end
			}
			current_path << file_name
			if(!force && File.exists?(current_path))
				raise "\nRequested File Exists at: " + Dir.pwd + File::SEPARATOR + current_path + ". \n\nUse -f option to overwrite."
			else
				file = File.new(current_path, 'w')
				@final_path = current_path
				file
			end
		end
		
		def target_file(setting)
			name = @template_name
			result = ''
			case name
				when AsUnit::CLASS_TEMPLATE
					return @settings.src + File::SEPARATOR + @resolver.path + @settings.file_extension
				when AsUnit::TEST_TEMPLATE
					return @settings.test + File::SEPARATOR + @resolver.path + @settings.file_extension
			end
			raise 'The requested template has not yet been supported at: ' + name
		end
		
		def get_dir setting
			return Dir.pwd + File::SEPARATOR + setting + File::SEPARATOR
		end
	end
end