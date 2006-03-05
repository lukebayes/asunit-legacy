import asunit.runner.IResultPrinter;
import asunit.framework.Test;
import asunit.framework.TestResult;

class asunit.runner.BaseTestRunner {
	private static var instance:BaseTestRunner;
	private var printer:IResultPrinter;
	
	public function BaseTestRunner(printerReference:Function) {
		if(printerReference == undefined) {
			throw new Error("BaseTestRunner instantiated without a ResultPrinter");
		}
		Stage.scaleMode = "noscale";
		Stage.align = "TL";
		instance = this;
		setPrinter(createResultPrinter(printerReference));
	}

	public static function getFilteredTrace(stack:String):String {
		return stack;
	}
	
	public function start(testCase:Function, testMethod:String, showTrace:Boolean):TestResult {
		try {
			var suite:Test = Test(new testCase(testMethod));
			return doRun(suite, showTrace);
		}
		catch(e:Error) {
			trace("ERROR: Failed to create and run test suite with: \n" + e.toString());
		}
	}
	
	public function doRun(suite:Test, showTrace:Boolean):TestResult {
		try {
			var result:TestResult = new TestResult();
			result.addListener(getPrinter());
			var startTime:Number = getTimer();
			suite.setResult(result);
			suite.setContext(getClipContext());
			suite.run();
			onTestsCompleted(result, startTime);
			return result;
		}
		catch(e:Error) {
			trace(e.toString());
		}
	}
	
	private function onTestsCompleted(result:TestResult, startTime:Number):Void {
		getPrinter().printResult(result, (getTimer() - startTime));
	}
	
	public static function trace(msg:String):Void {
		instance.getPrinter().trace(msg);
	}
	
	public function setPrinter(printer:IResultPrinter):Void {
		this.printer = printer;
	}
	
	public function getPrinter():IResultPrinter {
		return IResultPrinter(printer);
	}

	/*
	 * This function should return a refrence to the
	 * MovieClip that all test cases will attach items
	 * to. This MovieClip should probably *not* be _root.
	 */	
	public function getClipContext():MovieClip {
		return _root;
	}
	
	private static function createResultPrinter(reference:Function):IResultPrinter {
		var printer:IResultPrinter;
		if(printer == undefined) {
			printer = IResultPrinter(_root.attachMovie(reference.linkageId, "asUnitResultPrinter_" + 9000, 10000));
		}
		return printer;
	}
}