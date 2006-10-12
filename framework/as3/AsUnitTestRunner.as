package {
	import asunit.textui.TestRunner;
	import asunit.framework.TestCaseTest;
	
	public class AsUnitTestRunner extends TestRunner {

		public function AsUnitTestRunner() {
			start(AllTests, null, TestRunner.SHOW_TRACE);
//			start(TestCaseTest, "testCustomConstructor");
		}
	}
}
