
module AsUnit
	class Settings
		attr_accessor :src, :test, :lib	
		
		def initialize()
			@src = 'src'
			@test = 'test'
			@lib = 'lib'
		end
	end
end