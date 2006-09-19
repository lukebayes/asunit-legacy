package {
	import asunit.textui.TestRunner;
	import asunit.framework.TestCaseTest;
	import asunit.textui.TestRunnerTest;
	
	public class AsUnitTestRunner extends TestRunner {

		public function AsUnitTestRunner() {
//			start(AllTests, null, TestRunner.SHOW_TRACE);
			start(TestRunnerTest);
		}
	}
}
