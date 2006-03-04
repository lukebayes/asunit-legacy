package asunit.example {
	import asunit.framework.TestCase;

	public class OutputFormatterTest extends TestCase {
		private var instance:OutputFormatter;

		public function OutputFormatterTest(testMethod:String = null) {
			super(testMethod);
		}

		protected override function setUp():void {
			instance = new OutputFormatter("hello", new Array());
		}

		protected override function tearDown():void {
			delete instance;
		}

		public function testInstantiated():void {
			assertTrue("OutputFormatter instantiated", instance is OutputFormatter);
		}
	}
}
