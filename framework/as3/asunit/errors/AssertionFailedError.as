package asunit.errors {
	
	public class AssertionFailedError extends Error {
		public var name:String = "AssertionFailedError";
		
		public function AssertionFailedError(message:String) {
			super(message);
		}
	}
}