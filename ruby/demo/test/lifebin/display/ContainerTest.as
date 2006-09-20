package lifebin.display {
    import asunit.framework.TestCase;

    public class ContainerTest extends TestCase {
		private var instance:Container;

		public function ContainerTest(testMethod:String = null) {
		    super(testMethod);
		}

		protected override function setUp():void {
		    super.setUp();
		    instance = new Container();
		    addChild(instance);
		}

		protected override function tearDown():void {
		    super.tearDown();
		    removeChild(instance);
		    instance = null;
		}

		public function testInstantiated():void {
		  	assertTrue("ContainerTest instantiated", instance is Container);
		}

		public function test():void {
			assertTrue("ContainerTest default failing test", false);
		}
    }
}
