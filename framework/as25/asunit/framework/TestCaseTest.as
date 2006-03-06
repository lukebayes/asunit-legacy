
import asunit.framework.TestCaseMock;
import asunit.framework.TestCase;

class asunit.framework.TestCaseTest extends TestCase {
	private var className:String = "asunit.framework.TestCaseTest";
	private var instance:TestCaseMock;

	public function TestCaseTest(testMethod:String) {
		super(testMethod);
	}

	public function setUp():Void {
		var initObj:Object = new Object();
		instance = TestCaseMock(attachMovie(TestCaseMock.linkageId, initObj));
	}

	public function tearDown():Void {
		instance.removeMovieClip();
		delete instance;
	}

	public function testInstantiated():Void {
		assertTrue("TestCaseMock instantiated", instance instanceof TestCaseMock);
	}

	public function testView():Void {
	}
}
