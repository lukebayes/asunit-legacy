import asunit.textui.TestRunner;
import asunit.example.MyViewTest;

class AsUnitTestRunner extends TestRunner {
	
	public function AsUnitTestRunner() {
		start(AllTests);
//		start(MyViewTest, "testInstantiated");
	}
	
	public static function main():Void {
		var runner = new AsUnitTestRunner();
	}
}
