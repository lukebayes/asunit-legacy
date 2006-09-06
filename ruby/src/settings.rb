
module AsUnit
	class Settings
		attr_accessor :src, :test, :templates, :directories
		
		def initialize
			@directories = ['src', 'test', 'templates', 'css', 'xml']
			@src = 'src'
			@test = 'test'
			@templates = 'templates'
		end
	end
end