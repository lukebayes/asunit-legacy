package asunit.errors {
	
	public class UnimplementedFeatureError extends Error {
		public var name:String = "UnimplementedFeatureError";
		
		public function UnimplementedFeatureError(message:String) {
			super(message);
		}
	}
}