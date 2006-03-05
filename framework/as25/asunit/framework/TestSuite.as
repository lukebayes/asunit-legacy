import asunit.framework.TestCase;
import asunit.framework.Test;
import asunit.framework.TestResult;

class asunit.framework.TestSuite extends TestCase {
	private var fTests:Array = new Array();

	 public function TestSuite() {
	 	super();
	 	fTests = new Array();
	}

	private function getTestMethods():Array {
		return new Array();
	}
	/**
	 * Adds a test to the suite.
	 */
	public function addTest(test:Test):Void {
		fTests.push(test);
	}
	
	/**
	 * Counts the number of tests that will be run by this Suite.
	 */
	public function countTestCases():Number {
		var count:Number;
		var len:Number = fTests.length;
		for(var i:Number = 0; i < len; i++) {
			count = count + fTests[i].countTestCases();
		}
		return count;
	}
	
	/**
	 * Runs the tests and collects their result in a TestResult.
	 */
	public function run():Void {
		var result:TestResult = getResult();
		var test:TestCase;
		var len:Number = fTests.length;
		for(var i:Number = 0; i < len; i++) {
			test = TestCase(fTests[i]);
			test.setResult(result);
			test.run();
		}
	}

	/**
	 * Returns the number of tests in this suite
	 */
	public function testCount():Number {
		return fTests.length;
	}
	
	public function toString():String {
		return getName();
	}
	
	public function getIsComplete():Boolean {
		var len:Number = fTests.length;
		for(var i:Number = 0; i < len; i++) {
			if(!fTests[i].getIsComplete()) {
				return false;
			}
		}
		return true;
	}
	
	public function setContext(context:MovieClip):Void {
		super.setContext(context);
		var len:Number = fTests.length;
		for(var i:Number = 0; i < len; i++) {
			fTests[i].setContext(context);
		}
	}
}