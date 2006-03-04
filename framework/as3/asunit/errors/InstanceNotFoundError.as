package asunit.errors {
	
	public class InstanceNotFoundError extends Error {
		public var name:String = "InstanceNotFoundError";
		
		public function InstanceNotFoundError(message:String) {
			super(message);
		}
	}
}