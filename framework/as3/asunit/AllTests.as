package asunit {
	import asunit.framework.TestSuite;
	import asunit.framework.AllTests;

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(new asunit.framework.AllTests());
		}
	}
}
