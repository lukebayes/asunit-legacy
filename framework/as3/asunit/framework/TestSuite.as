package asunit.framework {
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import asunit.util.Iterator;
	import asunit.util.ArrayIterator;
	
	/**
	 * A <code>TestSuite</code> is a <code>Composite</code> of Tests.
	 * It runs a collection of test cases. Here is an example using
	 * the dynamic test definition.
	 * <pre>
	 * TestSuite suite = new TestSuite();
	 * suite.addTest(new MathTest());
	 * suite.addTest(new OtherTest());
	 * </pre>
	 * @see Test
	 * @see TestCase
	 */
	public class TestSuite extends TestCase implements Test {
		private var fTests:Array = new Array();
		private var testsCompleteCount:Number = 0;

		 public function TestSuite() {
		 	super();
		 	fTests = new Array();
		}

		protected override function setTestMethods(methodNodes:XMLList):void {
			testMethods = new Array();
		}
		
		/**
		 * Adds a test to the suite.
		 */
		public function addTest(test:Test):void {
			fTests.push(test);
		}
		
		/**
		 * Counts the number of tests that will be run by this Suite.
		 */
		public override function countTestCases():int {
			var count:int;
			for each(var test:TestCase in fTests) {
				count = count + test.countTestCases();
			}
			return count;
		}
		
		/**
		 * Runs the tests and collects their result in a TestResult.
		 */
		public override function run():void {
			var result:TestResult = getResult();
			var test:Test;
			var itr:Iterator = new ArrayIterator(fTests);
			while(itr.hasNext()) {
				test = Test(itr.next());
				test.setResult(result);
				test.addEventListener(Event.COMPLETE, testCompleteHandler);
				test.run();
			}
		}
		
		private function testCompleteHandler(event:Event):void {
			if(++testsCompleteCount >= testCount()) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		/**
		 * Returns the number of tests in this suite
		 */
		public function testCount():int {
			return fTests.length;
		}
		
		public override function toString():String {
			return getName();
		}
		
		public override function getIsComplete():Boolean {
			for each(var test:TestCase in fTests) {
				if(!test.getIsComplete()) {
					return false;
				}
			}
			return true;
		}
		
		public override function setContext(context:DisplayObjectContainer):void {
			super.setContext(context);
			for each(var test:Test in fTests) {
				test.setContext(context);
			}
		}
	}
}