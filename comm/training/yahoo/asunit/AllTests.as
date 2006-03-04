package asunit {
	import asunit.framework.TestSuite;
	import asunit.example.AllTests;

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(new asunit.example.AllTests());
		}
	}
}
