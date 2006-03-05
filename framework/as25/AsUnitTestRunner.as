import asunit.textui.TestRunner;

class AsUnitTestRunner extends TestRunner {
	
	public function AsUnitTestRunner() {
		start(AllTests);
	}
	
	public static function main():Void {
		var runner = new AsUnitTestRunner();
	}
}
