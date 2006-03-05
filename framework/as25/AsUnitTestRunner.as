import asunit.textui.TestRunner;

class AsUnitTestRunner extends TestRunner {
	
	public function AsUnitTestRunner() {
		start(asunit.framework.ObjectTest);
	}
	
	public static function main():Void {
		var runner = new AsUnitTestRunner();
	}
}
