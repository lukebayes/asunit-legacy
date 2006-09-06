
require 'template_resolver'

module AsUnit
	class CreateClass
		attr_accessor :settings, :classname, :template_name

		def initialize(name, settings, template)
			@classname = name
			@settings = settings
			@template_name = template
			@resolver = AsUnit::TemplateResolver.new @classname
		end
		
		def run
			src = Dir.pwd + File::SEPARATOR + settings.templates + File::SEPARATOR + template_name
			puts 'opening: ' + src
			template = IO.read(src)
			@resolver.template = template
			
			puts @resolver.parse
#			file = File.new(src)
		end
	end
end