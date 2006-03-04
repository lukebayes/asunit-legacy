package asunit.framework {
	
	public class TestFailureTest extends TestCase {
		
		public function testInstantiated():void {
			var failure:TestFailure = new TestFailure(this, new Error());
			assertTrue(failure is TestFailure);
		}
	}
}