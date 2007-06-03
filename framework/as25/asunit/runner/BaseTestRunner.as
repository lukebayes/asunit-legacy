import asunit.runner.IResultPrinter;
import asunit.framework.Test;
import asunit.framework.TestResult;
import asunit.framework.Assert;
import asunit.textui.ResultPrinter;

class asunit.runner.BaseTestRunner {
	private static var instance:BaseTestRunner;
	private static var clipContext:MovieClip;
	private var printer:IResultPrinter;
	private var intervalId:Number;
	
	public function BaseTestRunner(printerReference:Function) {
		if(printerReference == undefined) {
			throw new Error("BaseTestRunner instantiated without a ResultPrinter");
		}
		Stage.scaleMode = "noscale";
		Stage.align = "TL";
		instance = this;
		setClipContext(_root);
		setPrinter(createResultPrinter(printerReference));
	}

	public static function getFilteredTrace(stack:String):String {
		return stack;
	}
	
	public function start(testCase:Function, testMethod:String, showTrace:Boolean):TestResult {
		try {
			getPrinter().setShowTrace(showTrace);
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
			clearInterval(intervalId);
			intervalId = setInterval(this, "completionHandler", 1, suite, result, startTime);
			return result;
		}
		catch(e:Error) {
			trace(e.toString());
		}
	}
	
	private function completionHandler(suite:Test, result:TestResult, startTime:Number):Void {
		if(suite.testsComplete()) {
			clearInterval(intervalId);
			getPrinter().printResult(result, (getTimer() - startTime));
		}
	}
	
	public static function trace(msg:String):Void {
		getInstance().getPrinter().traceln(msg);
	}
	
	public static function getInstance():BaseTestRunner {
		if(instance == undefined) {
			return instance = new BaseTestRunner(ResultPrinter);
		}
		return instance;
	}
	
	public function setPrinter(printer:IResultPrinter):Void {
		this.printer = printer;
	}
	
	public function getPrinter():IResultPrinter {
		return IResultPrinter(printer);
	}

	public function setClipContext(context:MovieClip):Void {
		BaseTestRunner.clipContext = context;
	}
	/*
	 * This function should return a reference to the
	 * MovieClip that all test cases will attach items
	 * to. This MovieClip should probably *not* be _root.
	 */	
	public function getClipContext():MovieClip {
		return BaseTestRunner.clipContext;
	}
	
	private static function createResultPrinter(reference:Function):IResultPrinter {
		var printer:IResultPrinter;
		if(printer == undefined) {
			var context:MovieClip = BaseTestRunner.clipContext;
			printer = IResultPrinter(context.attachMovie(reference.linkageId, "asUnitResultPrinter_" + 9000, Assert.nextDepth()));
		}
		return printer;
	}
}