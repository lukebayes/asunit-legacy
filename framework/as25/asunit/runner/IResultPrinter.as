import asunit.framework.ITestListener;
import asunit.framework.TestResult;

interface asunit.runner.IResultPrinter extends ITestListener {
	
	public function printResult(result:TestResult, runTime:Number):Void;
	public function trace():Void;
}