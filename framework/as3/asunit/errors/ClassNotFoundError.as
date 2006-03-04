package asunit.errors {
	
	public class ClassNotFoundError extends Error {
		public var name:String = "ClassNotFoundError";
		
		public function ClassNotFoundError(message:String) {
			super(message);
		}	
	}
}