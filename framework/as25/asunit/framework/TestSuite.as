import asunit.framework.TestCase;
import asunit.framework.Test;

class asunit.framework.TestSuite extends TestCase {
	
	public function addTest(test:Test):Void {
		trace("addTest called with: " + test);
	}
}