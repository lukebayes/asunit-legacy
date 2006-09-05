
module AsUnit
	class Settings
		attr_accessor :src, :test, :template, :directories
		
		def initialize()
			@directories = ['src', 'test', 'templates', 'css', 'xml']
			@src = 'src'
			@test = 'test'
			@template = 'template'
		end
	end
end