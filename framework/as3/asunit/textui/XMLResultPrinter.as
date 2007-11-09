package asunit.textui {

	import asunit.framework.TestResult;
	import asunit.framework.TestFailure;
	import asunit.framework.Test;
	import flash.utils.Dictionary;
	
	public class XMLResultPrinter extends ResultPrinter {
		
		protected var results:Dictionary;
		protected var currentResult:XMLTestResult;
		
		public function XMLResultPrinter() {
			results = new Dictionary();
		}

		override public function startTest(test:Test):void {
			super.startTest(test);
			results[test.getName()] = new XMLTestResult(test);
		}

/*
<testsuites>
  <testsuite name="Flash Profile Card AsUnit Test Suite" errors="1" failures="1" tests="8" time="8.002">
    <testcase classname="lib.test.cases.FailureTest" name="testError">
      <failure type="Error">Reference runtime test error</failure>
    </testcase>
    <testcase classname="lib.test.cases.FailureTest" name="testAssertion">
      <failure type="AssertionFailedError">Reference assertion test failure</failure>
    </testcase>
  </testsuite>
</testsuites>
*/
		override public function printResult(result:TestResult, runTime:Number):void {
			super.printResult(result, runTime);

			if(result.errorCount()) {
				var error:TestFailure;
				for each(error in result.errors()) {
					results[error.failedTest().getName()].addFailure(error);
				}
			}
			if(result.failureCount()) {
				var failure:TestFailure;
				for each(failure in result.failures()) {
					results[failure.failedTest().getName()].addFailure(failure);
				}
			}
			trace("<XMLResultPrinter>");
			trace("<?xml version='1.0' encoding='UTF-8'?>");
			trace("<testsuites>");
			trace("<testsuite name='AsUnit Test Suite' errors='" + result.errorCount() + "' failures='" + result.failureCount() + "' tests='" + result.runCount() + "' time='" + elapsedTimeAsString(runTime) + " seconds'>");
			var xmlTestResult:XMLTestResult;
			for each(xmlTestResult in results) {
				trace(xmlTestResult.toString());
			}
			trace("</testsuite>");
			trace("</testsuites>");
			trace("</XMLResultPrinter>");
		}
	}
}

import asunit.framework.Test;
import asunit.framework.TestFailure;	

class XMLTestResult {
	
	private var test:Test;
	private var failures:Array;
	private var errors:Array;
	
	public function XMLTestResult(test:Test) {
		this.test = test;
		failures = new Array();
	}
	
	public function addFailure(failure:TestFailure):void {
		failures.push(failure);
	}
	
	private function renderFailures():String {
		var result:String = "";
		var failure:TestFailure;
		for each(failure in failures) {
			result += "<failure type='" + failure.thrownException().name + "'>" + failure.thrownException().getStackTrace() + "\n</failure>\n";
		}
		return result;
	}
	
	private function renderOpener(methodName:String):String {
		return "<testcase classname='" + test.getName() + "' name='" + methodName + "'>\n";
	}
	
	private function renderFailure(methodName:String):String {
		var failure:TestFailure;
		for each(failure in failures) {
			if(failure.failedMethod() == methodName) {
				return "<failure type='" + failure.thrownException().name + "'>" + failure.thrownException().getStackTrace() + "\n</failure>\n";
			}
		}
		return '';
	}
		
	private function renderCloser():String {
		return '</testcase>\n';
	}
	
	public function toString():String {
		var str:String = '';
		var method:String;
		var failure:TestFailure;
		for each(method in test.getTestMethods()) {
			str += renderOpener(method);
			str += renderFailure(method);
			str += renderCloser();
		}
		return str;
	}
}
