
module AsUnit
	class Settings
		@@FILE_EXTENSION = '.as'

		attr_accessor :src, :test, :templates, :file_extension, :directories

		def initialize
			@directories = ['src', 'test', 'templates', 'css', 'xml']
			@src = 'src'
			@test = 'test'
			@templates = 'templates'
			@file_extension = @@FILE_EXTENSION
		end
	end
end