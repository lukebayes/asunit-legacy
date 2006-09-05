
module AsUnit
	class CreateClass
		def initialize name
			@classname = name;
		end
		
		def full_class_name
			return @classname
		end
	end
end
