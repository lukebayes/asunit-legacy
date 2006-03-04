package asunit.framework {
	
	public class AllTests extends TestSuite {
		
		public function AllTests() {
			addTest(new AssertTest());
			addTest(new TestCaseTest());
			addTest(new TestFailureTest());
			addTest(new VisualTestCaseTest());
			addTest(new AsynchronousTestCaseExample());
		}
	}
}