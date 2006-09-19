package asunit.textui {
	import asunit.errors.AbstractMemberCalledError;
	import asunit.framework.Test;
	import asunit.framework.TestResult;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.fscommand;
	import flash.utils.clearInterval;
	import flash.utils.describeType;
	import flash.utils.getTimer;
	import flash.utils.setInterval;

	/**
	 * A command line based tool to run tests.
	 * <pre>
	 * java junit.textui.TestRunner TestCaseClass
	 * </pre>
	 * TestRunner expects the name of a TestCase class as argument.
	 * If this class defines a static <code>suite</code> method it
	 * will be invoked and the returned test is run. Otherwise all
	 * the methods starting with "test" having no arguments are run.
	 * <p>
	 * TestRunner prints a trace as the tests are executed followed by a
	 * summary at the end.
	 */
	public class TestRunner extends Sprite {
		public static const SUCCESS_EXIT:int   = 0;
		public static const FAILURE_EXIT:int   = 1;
		public static const EXCEPTION_EXIT:int = 2;
		public static const SHOW_TRACE:Boolean = true;
		protected var fPrinter:ResultPrinter;

		public function TestRunner() {
			configureListeners();
		}

		private function configureListeners():void {
			addEventListener(Event.ADDED, addedHandler);
//			addEventListener(KeyboardEventType.KEY_DOWN, onKeyDown);
		}

		protected function addedHandler(event:Event):void {
			if(event.target === fPrinter) {
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.addEventListener(Event.RESIZE, resizeHandler);
				resizeHandler(new Event("resize"));
			}
		}

		private function resizeHandler(event:Event):void {
			fPrinter.width = stage.stageWidth;
			fPrinter.height = stage.stageHeight;
		}

		/**
		 * Starts a test run based on the TestCase/TestSuite provided
		 * Create a new custom class that extends TestRunner
		 * and call start(TestCaseClass) from within the
		 * constructor.
		 */
		public function start(testCase:Class, testMethod:String = null, showTrace:Boolean = false):TestResult {
//			fscommand("showmenu", "false");

			try {
				var suite:Test;
				if(testMethod != null) {
					suite = new testCase(testMethod);
				}
				else {
					suite = new testCase();
				}
				return doRun(suite, showTrace);
			}
			catch(e:Error) {
				throw new Error("Could not create and run test suite: " + e.getStackTrace());
			}
			return null;
		}

		public function doRun(suite:Test, showTrace:Boolean = false):TestResult {
			var result:TestResult = new TestResult();
			if(fPrinter == null) {
				setPrinter(new ResultPrinter(showTrace));
			}
			else {
				fPrinter.setShowTrace(showTrace);
			}
			result.addListener(getPrinter());
			var startTime:Number = getTimer();
			suite.setResult(result);
			suite.setContext(this);
			suite.run();

			// Wait for all tests to be completed before finishing
			// the output.
			// This is how we are going to support asynchronous
			// TestCases.
			var intervalObj:Object 	= new Object();
			intervalObj.startTime 	= startTime;
			intervalObj.result 		= result;
			intervalObj.suite 		= suite;
			intervalObj.runOnce 	= false;
			// If you have no asynchronous TestCases, this will complete
			// in one millisecond
			intervalObj.intervalId 	= setInterval(onTestCompleted, 1, intervalObj);

			return result;
		}

		private function onTestCompleted(intervalObj:Object):void {
			if(intervalObj.suite.getIsComplete()) {
				var endTime:Number = getTimer();
				var runTime:Number = endTime - intervalObj.startTime;
				getPrinter().printResult(intervalObj.result, runTime);
				clearInterval(intervalObj.intervalId);
			} else if(!intervalObj.runOnce) {
				// If you have an asynchronous TestCase, poll at less frequent intervals
				clearInterval(intervalObj.intervalId);
				intervalObj.runOnce = true;
				intervalObj.intervalId = setInterval(onTestCompleted, 20, intervalObj);
			}
		}

		public function setPrinter(printer:ResultPrinter):void {
			if(fPrinter == null) {
				fPrinter = printer;
				addChild(fPrinter);
			}
		}

		public function getPrinter():ResultPrinter {
			return fPrinter;
		}
	}
}