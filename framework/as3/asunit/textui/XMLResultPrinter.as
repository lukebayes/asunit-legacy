package asunit.textui {

	import asunit.framework.TestResult;
	import asunit.framework.TestFailure;
	
	public class XMLResultPrinter extends ResultPrinter {

		override public function printResult(result:TestResult, runTime:Number):void {
			super.printResult(result, runTime);
			trace("<XMLResultPrinter>");
			trace("PRINT RESULT CALLED with: ");
			trace("runCount: " + result.runCount());
			trace("errorCount: " + result.errorCount());
			trace("failureCount: " + result.failureCount());
			if(result.errorCount()) {
				var error:TestFailure;
				for each(error in result.errors()) {
					trace("error: " + error.toString());
				}
			}
			if(result.failureCount()) {
				var failure:TestFailure;
				for each(failure in result.failures()) {
					trace("failure: " + failure.thrownException().getStackTrace());
				}
			}
			trace("</XMLResultPrinter>");
		}
	}
}
