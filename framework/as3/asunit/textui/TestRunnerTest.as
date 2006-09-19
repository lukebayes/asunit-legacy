package asunit.textui {
	import asunit.framework.TestCase;
	import flash.utils.setTimeout;

	public class TestRunnerTest extends TestCase {
		private var instance:TestRunner;

		public function TestRunnerTest(testMethod:String = null) {
			super(testMethod);
		}

		protected override function setUp():void {
			instance = new TestRunner();
			addChild(instance);
		}

		protected override function tearDown():void {
			removeChild(instance);
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("TestRunner instantiated", instance is TestRunner);
		}

//		public function testAsync():void {
//			setTimeout(testAsyncComplete, 10);
//		}
		
//		public function testAsyncComplete():void {
//			fail("test async complete failed");
//			runBare();
//		}
		
		public function testSomethingComplete():void {
			trace("testSomethignCOmplete executed");
		}
	}
}
