import asunit.runner.BaseTestRunner;
import asunit.textui.ResultPrinter;

/*
 * This concrete TestRunner is simply created in order
 * to choose a concrete ResultPrinter... This was
 * set up so that we can easily output results
 * to any target desired - this should include
 * XMLSocket, LocalConnection, trace window, 
 * file system, etc.
 */
class asunit.textui.TestRunner extends BaseTestRunner {
	
	public function TestRunner() {
		super(ResultPrinter);
	}
}
