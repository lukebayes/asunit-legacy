
module AsUnit
	class Settings
		@@FILE_EXTENSION = '.as'

		attr_accessor :src, :test, :templates, :file_extension, :directories

		def initialize(hash)
			@directories = ['src', 'test', 'templates', 'css', 'xml']
			@src = 'src'
			@test = 'test'
			@templates = 'templates'
			@file_extension = @@FILE_EXTENSION
			
			if(!hash['src'].nil?)
				@src = hash['src']
			end
			if(!hash['test'].nil?)
				@test = hash['test']
			end
			if(!hash['templates'].nil?)
				@templates = hash['templates']
			end
			if(!hash['file_extension'].nil?)
				@file_extension = hash['file_extension']
			end

		end
	end
end