
import [%PACKAGE_NAME%].*;

class [%PACKAGE_NAME%].[%TEST_NAME%] extends com.asunit.framework.TestCase {
	private var className:String = "[%TEST_PACKAGE_NAME%].[%TEST_NAME%]";
	private var instance:[%CLASS_NAME%];

	public function setUp():Void {
		instance = new [%CLASS_NAME%]();
	}

	public function tearDown():Void {
		delete instance;
 	}

 	public function testInstantiated():Void {
		assertTrue("[%CLASS_NAME%] instantiated", instance instanceof [%CLASS_NAME%]);
	}
	
	public function test():Void {
		assertTrue("failingtest", false);
	}
}
