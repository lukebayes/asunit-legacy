
import asunit.framework.Assert;
import asunit.framework.TestCase;
import asunit.errors.AssertionFailedError;
import asunit.framework.AssertMock;
import asunit.errors.IllegalOperationError;

class asunit.framework.AssertTest extends TestCase {
	private var className:String = "asunit.framework.AssertTest";
	private var instance:AssertMock;

	public function AssertTest(testMethod:String) {
		super(testMethod);
	}

	public function setUp():Void {
		instance = new AssertMock();
	}

	public function tearDown():Void {
		delete instance;
	}

	public function testAssertTrueFailureA():Void {
		try {
			instance.assertTrue(false);
			fail("assertTrue(false) should throw");
		}
		catch(e) {
			if(!(e instanceof AssertionFailedError)) {
				fail("assertTrue should have thrown an AssertionFailedError");
			}
		}
	}

//			instance.assertTrue("faux message", false);

	public function testAssertTrueTooManyArgs():Void {
		try {
			instance.assertTrue("faux message", false, false);
			fail("assertTrue should have failed with too many args");
		}
		catch(e) {
			if(!(e instanceof IllegalOperationError)) {
				fail(e.toString());
			}
		}
	}

	public function testAssertTrueSuccess():Void {
		try {
			instance.assertTrue(true);
			instance.assertTrue("faux message", true);
		}
		catch(e) {
			fail("assertTrue should not have thrown");
		}
	}
}
