package asunit.errors {
	
	public class AbstractMemberCalledError extends Error {
		public var name:String = "AbstractMemberCalledError";
		
		public function AbstractMemberCalledError(message:String) {
			super(message);
		}
	}
}