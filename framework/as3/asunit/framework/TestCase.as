package asunit.framework {
	import flash.util.describeType;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.errors.IllegalOperationError;
	import asunit.errors.AssertionFailedError;

	/**
	 * A test case defines the fixture to run multiple tests. To define a test case<br>
	 * 1) implement a subclass of TestCase<br>
	 * 2) define instance variables that store the state of the fixture<br>
	 * 3) initialize the fixture state by overriding <code>setUp</code><br>
	 * 4) clean-up after a test by overriding <code>tearDown</code>.<br>
	 * Each test runs in its own fixture so there
	 * can be no side effects among test runs.
	 * Here is an example:
	 * <pre>
	 * public class MathTest extends TestCase {
	 *     protected double fValue1;
	 *     protected double fValue2;
	 *
	 *    protected void setUp() {
	 *         fValue1= 2.0;
	 *         fValue2= 3.0;
	 *     }
	 * }
	 * </pre>
	 *
	 * For each test implement a method which interacts
	 * with the fixture. Verify the expected results with assertions specified
	 * by calling <code>assertTrue</code> with a boolean.
	 * <pre>
	 *    public void testAdd() {
	 *        double result= fValue1 + fValue2;
	 *        assertTrue(result == 5.0);
	 *    }
	 * </pre>
	 * Once the methods are defined you can run them. The framework supports
	 * both a static type safe and more dynamic way to run a test.
	 * In the static way you override the runTest method and define the method to
	 * be invoked. A convenient way to do so is with an anonymous inner class.
	 * <pre>
	 * TestCase test= new MathTest("add") {
	 *        public void runTest() {
	 *            testAdd();
	 *        }
	 * };
	 * test.run();
	 * </pre>
	 * The dynamic way uses reflection to implement <code>runTest</code>. It dynamically finds
	 * and invokes a method.
	 * In this case the name of the test case has to correspond to the test method
	 * to be run.
	 * <pre>
	 * TestCase= new MathTest("testAdd");
	 * test.run();
	 * </pre>
	 * The tests to be run can be collected into a TestSuite. JUnit provides
	 * different <i>test runners</i> which can run a test suite and collect the results.
	 * A test runner either expects a static method <code>suite</code> as the entry
	 * point to get a test to run or it will extract the suite automatically.
	 * <pre>
	 * public static Test suite() {
	 *      suite.addTest(new MathTest("testAdd"));
	 *      suite.addTest(new MathTest("testDivideByZero"));
	 *      return suite;
	 *  }
	 * </pre>
	 * @see TestResult
	 * @see TestSuite
	 */

	public class TestCase extends Assert implements Test {
		/**
		 * the name of the test case
		 */
		protected var fName:String;
		protected var result:TestResult;
		protected var testMethods:Array;
		protected var isComplete:Boolean;
		protected var context:DisplayObjectContainer;
		private var currentMethod:String;
		private var runSingle:Boolean;


		/**
		 * Constructs a test case with the given name.
		 */
		public function TestCase(testMethod:String = null) {
			var description:XML = describeType(this);
			var className:Object = description.@name;
			var methods:XMLList = description..method.(@name.match("^test"));
			if(testMethod != null) {
				runSingle = true;
				testMethods = testMethod.split(", ").join(",").split(",");
			} else {
				setTestMethods(methods);
			}
			setName(className.toString());
		}

		/**
		 * Sets the name of a TestCase
		 * @param name The name to set
		 */
		public function setName(name:String):void {
			fName = name;
		}

		protected function setTestMethods(methodNodes:XMLList):void {
			testMethods = new Array();
			var methodNames:Object = methodNodes.@name;
			for each(var item:Object in methodNames) {
				testMethods.push(item.toString());
			}
		}

		/**
		 * Counts the number of test cases executed by run(TestResult result).
		 */
		public function countTestCases():int {
			return testMethods.length;
		}

		/**
		 * Creates a default TestResult object
		 *
		 * @see TestResult
		 */
		protected function createResult():TestResult {
		    return new TestResult();
		}

		/**
		 * A convenience method to run this test, collecting the results with
		 * either the TestResult provided or a default, new TestResult object.
		 * Expects either:
		 * run():void // will return the newly created TestResult
		 * run(result:TestResult):TestResult // will use the TestResult
		 * that was passed in.
		 *
		 * @see TestResult
		 */
		public function run():void {
			var result:TestResult = getResult();
			result.run(this);
		}

		public function setResult(result:TestResult):void {
			this.result = result;
		}

		protected function getResult():TestResult {
			return (result == null) ? createResult() : result;
		}

		/**
		 * Runs the bare test sequence.
		 * @exception Error if any exception is thrown
		 *  throws Error
		 */
		public function runBare():void {
			var methods:Array = testMethods;
			try {
				for each(var name:String in methods) {
					try {
						runMethod(name);
					}
					catch(e:AssertionFailedError) {
						result.addFailure(this, e);
					}
					catch(ioe:Error) {
						result.addError(this, ioe);
					}
				}
			}
			finally {
				if(!runSingle) {
					cleanUp();
				}
			}

			isComplete = true;
		}

		// Override this method in Asynchronous test cases
		// or any other time you want to perform additional
		// member cleanup after all test methods have run
		protected function cleanUp():void {
		}

		private function runMethod(methodName:String):void {
			setUp();
			currentMethod = methodName;
			try {
				this[methodName]();
			}
			finally {
				if(!runSingle) {
					tearDown();
				}
			}
		}

		/**
		 * Sets up the fixture, for example, instantiate a mock object.
		 * This method is called before each test is executed.
		 * throws Exception on error
		 */
		protected function setUp():void {
		}
		/**
		 * Tears down the fixture, for example, delete mock object.
		 * This method is called after a test is executed.
		 *  throws Exception on error
		 */
		protected function tearDown():void {
		}
		/**
		 * Returns a string representation of the test case
		 */
		public function toString():String {
			return getName() + "." + getCurrentMethod() + "()";
		}
		/**
		 * Gets the name of a TestCase
		 * @return returns a String
		 */
		public function getName():String {
			return fName;
		}

		public function getCurrentMethod():String {
			return currentMethod;
		}

		public function getIsComplete():Boolean {
			return isComplete;
		}

		public function setContext(context:DisplayObjectContainer):void {
			this.context = context;
		}

		public function getContext():DisplayObjectContainer {
			return context;
		}

		protected function addChild(child:DisplayObject):DisplayObject {
			return getContext().addChild(child);
		}

		protected function removeChild(child:DisplayObject):DisplayObject {
			return getContext().removeChild(child);
		}

	}
}