import asunit.textui.TestRunner;
import asunit.framework.TestCaseTest;

class AsUnitTestRunner extends TestRunner {
	
	public function AsUnitTestRunner() {
		fscommand("fullscreen", "true");
		start(AllTests);
//		start(TestCaseTest, "testView");
	}
	
	public static function main():Void {
		var runner = new AsUnitTestRunner();
	}
}
