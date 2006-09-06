
require 'template_resolver'

module AsUnit
	class CreateClass
		attr_accessor :settings, :template_name

		def initialize(name, settings, template)
			@settings = settings
			@template_name = template
			@resolver = AsUnit::TemplateResolver.new name
		end
		
		def run
			src = Dir.pwd + File::SEPARATOR + settings.templates + File::SEPARATOR + template_name
			puts 'opening: ' + src
			template = IO.read(src)
			@resolver.template = template
			parsed = @resolver.parse
			file = create_file(target_file(settings.src))
			file.write(parsed)
		end
		
		def create_file(relative)
			segments = relative.split(File::SEPARATOR)
			file_name = segments.pop
			current_path = ''
			segments.each { |dir|
				current_path << dir << File::SEPARATOR 
				if(!File.exists? current_path)
					Dir.mkdir(current_path)
				end
			}
			current_path << file_name
			if(File.exists?(current_path))
				raise 'Requested File Exists at: ' + Dir.pwd + File::SEPARATOR + current_path
			else
				file = File.new(current_path, 'w')
			end
		end
		
		def target_file(setting)
			if(@template_name == 'Class.erb')
				puts Dir.pwd
				return @settings.src + File::SEPARATOR + @resolver.path + @settings.file_extension
#				return get_dir(setting) + @resolver.path + @settings.file_extension
			end
		end
		
		def get_dir setting
			return Dir.pwd + File::SEPARATOR + setting + File::SEPARATOR
		end
	end
end