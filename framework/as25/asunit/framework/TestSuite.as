import asunit.framework.TestCase;
import asunit.framework.Test;
import asunit.framework.TestResult;
import asunit.util.Iterator;
import asunit.util.ArrayIterator;

class asunit.framework.TestSuite extends TestCase {
	private var fTests:Array = new Array();

	 public function TestSuite() {
	 	super();
	 	fTests = new Array();
	}

	private function getTestMethods():Array {
		return new Array();
	}
	
	public function testsComplete():Boolean {
		var completed:Boolean;
		var len:Number = fTests.length;
		for(var i:Number = 0; i < len; i++) {
			if(!fTests[i].testsComplete()) {
				return false;
			}
		}
		return true;
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
		runTests(fTests, result);
 	}
	
	public function runTests(tests:Array, result:TestResult):Void {
		var itr:Iterator = new ArrayIterator(tests);
		var test:TestCase;
		if(itr.hasNext()) {
			test = TestCase(itr.next());
			runTest(itr, test, result);
		}
	}
	
	public function runTest(itr:Iterator, test:TestCase, result:TestResult):Void {
		test.setResult(result);
		test.run();
		if(itr.hasNext()) {
			_global.setTimeout(this, "runTest", 10, itr, itr.next(), result);
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