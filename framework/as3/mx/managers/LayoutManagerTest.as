package mx.managers {
	import asunit.framework.TestCase;
	import mx.core.Container;

	public class LayoutManagerTest extends TestCase {
		private var container:MockContainer;
		private var instance:LayoutManager;
		
		public function LayoutManagerTest(testMethod:String=null) {
			super(testMethod);
		}
		
		override protected function setUp():void {
			trace("set up");
			instance = LayoutManager.getInstance();
			container = new MockContainer();
			addChild(container);
		}
		
		override protected function tearDown():void {
			trace("tearDown");
			removeChild(container);
			container = null;
		}
		
		public function testInstantiated():void {
			assertTrue(instance is LayoutManager);
		}
		
		public function testContainer():void {
			assertTrue(container is MockContainer);
		}
	}
}