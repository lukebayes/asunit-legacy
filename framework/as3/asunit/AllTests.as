package asunit {
	import asunit.framework.TestSuite;
	import asunit.runner.AllTests;
	import asunit.textui.AllTests;

	public class AllTests extends TestSuite {
		
		public function AllTests() {
			addTest(new asunit.errors.AllTests());
			addTest(new asunit.framework.AllTests());
			addTest(new asunit.runner.AllTests());
			addTest(new asunit.textui.AllTests());		
		}
	}
}