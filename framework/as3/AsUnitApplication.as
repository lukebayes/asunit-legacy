package {
	import asunit.framework.TestResult;
	import mx.core.Application;
	import asunit.textui.TestRunner;
	import asunit.textui.FlexTestRunner;
	
	public class AsUnitApplication extends Application {
		protected var runner:TestRunner;

		override protected function createChildren():void {
			super.createChildren();
			runner = new FlexTestRunner();
			rawChildren.addChild(runner);
		}
		
		public function start(testCase:Class, testMethod:String = null, showTrace:Boolean = false):TestResult {
			return runner.start(testCase, testMethod, showTrace);
		}
	}
}
