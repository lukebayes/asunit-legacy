//import flash.util.StringBuilder;
import asunit.errors.AssertionFailedError;
import asunit.framework.Test;

/**
 * A <code>TestFailure</code> collects a failed test together with
 * the caught exception.
 * @see TestResult
 */
class asunit.framework.TestFailure {
	private var fFailedTest:String;
	private var fThrownException:Error;
	
	/**
	 * Constructs a TestFailure with the given test and exception.
	 */
	public function TestFailure(failedTest:Test, thrownException:Error) {
		fFailedTest = failedTest.toString();
		fThrownException = thrownException;
	}
	/**
	 * Gets the failed test.
	 */
	public function failedTest():String {
	    return fFailedTest;
	}
	/**
	 * Gets the thrown exception.
	 */
	public function thrownException():Error {
	    return fThrownException;
	}
	/**
	 * Returns a short description of the failure.
	 */
	public function toString():String {
		return "";
	}

	public function exceptionMessage():String {
		return thrownException().message;
	}

	public function isFailure():Boolean {
		return thrownException() instanceof AssertionFailedError;
	}
}