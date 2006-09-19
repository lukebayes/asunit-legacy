package asunit.framework {
	import asunit.framework.TestSuite;
	import asunit.framework.AssertTest;
	import asunit.framework.TestCaseTest;
	import asunit.framework.TestFailureTest;
	import asunit.framework.TestSuiteTest;
	import asunit.framework.VisualTestCaseTest;

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(new asunit.framework.AssertTest());
			addTest(new asunit.framework.TestCaseTest());
			addTest(new asunit.framework.TestFailureTest());
			addTest(new asunit.framework.TestSuiteTest());
			addTest(new asunit.framework.VisualTestCaseTest());
		}
	}
}
