package asunit.example {
	import asunit.framework.TestSuite;
	import asunit.example.LivePreviewControllerTest;
	import asunit.example.LivePreviewModelTest;
	import asunit.example.LivePreviewViewTest;
	import asunit.example.OutputFormatterTest;

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(new asunit.example.LivePreviewControllerTest());
			addTest(new asunit.example.LivePreviewModelTest());
			addTest(new asunit.example.LivePreviewViewTest());
			addTest(new asunit.example.OutputFormatterTest());
		}
	}
}
