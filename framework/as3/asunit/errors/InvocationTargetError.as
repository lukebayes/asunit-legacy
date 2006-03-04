package asunit.errors {
	
	public class InvocationTargetError extends Error {
		public var name:String = "InvocationTargetError";
		
		public function InvocationTargetError(message:String) {
			super(message);
		}
	}
}