package asunit.runner {
	/**
	 * A listener interface for observing the
	 * execution of a test run. Unlike TestListener,
	 * this interface using only primitive objects,
	 * making it suitable for remote test execution.
	 */
	 public interface TestRunListener {
	     /* test status constants*/
	     static const STATUS_ERROR:int;
	     static const STATUS_FAILURE:int;
	
	     function testRunStarted(testSuiteName:String, testCount:int):void;
	     function testRunEnded(elapsedTime:Number):void;
	     function testRunStopped(elapsedTime:Number):void;
	     function testStarted(testName:String):void;
	     function testEnded(testName:String):void;
	     function testFailed(status:int, testName:String, trace:String):void;
	}
}