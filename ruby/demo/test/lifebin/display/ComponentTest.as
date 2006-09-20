package lifebin.display {
    import asunit.framework.TestCase;

    public class ComponentTest extends TestCase {
		private var instance:Component;

		public function ComponentTest(testMethod:String = null) {
		    super(testMethod);
		}

		protected override function setUp():void {
		    super.setUp();
		    instance = new Component();
		}

		protected override function tearDown():void {
		    super.tearDown();
		    instance = null;
		}

		public function testInstantiated():void {
		  	assertTrue("ComponentTest instantiated", instance is Component);
		}

		public function test():void {
			assertTrue("ComponentTest default failing test", false);
		}
    }
}
