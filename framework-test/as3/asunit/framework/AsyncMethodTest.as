package asunit.framework {
	import asunit.framework.TestCase;
	import flash.display.Sprite;
	import flash.utils.setTimeout;

	public class AsyncMethodTest extends TestCase {
		private var instance:Sprite;

		public function AsyncMethodTest(testMethod:String = null) {
			super(testMethod);
		}

		protected override function setUp():void {
			instance = new Sprite();
			addChild(instance);
		}

		protected override function tearDown():void {
			removeChild(instance);
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("Sprite instantiated", instance is Sprite);
		}

		public function testAsyncMethod():void {
			var handler:Function = addAsync(asyncHandler);
			setTimeout(handler, 100);
		}
		
		private function asyncHandler():void {
			assertTrue(instance is Sprite);
		}
		
		public function testAsyncVisualEntity():void {
			var handler:Function = addAsync(spriteHandler);
			setTimeout(handler, 100);
		}
		
		private function spriteHandler():void {
			assertTrue(instance is Sprite);
		}
		
		public function testAsyncVisualEntity2():void {
			var handler:Function = addAsync(spriteHandler);
			setTimeout(handler, 100);
		}
	}
}
