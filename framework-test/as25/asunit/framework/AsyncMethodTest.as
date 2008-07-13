import asunit.flash.utils.Timer;
import asunit.framework.TestCase;

class asunit.framework.AsyncMethodTest extends TestCase {
	private var instance:MovieClip;

	public function AsyncMethodTest(testMethod:String) {
		super(testMethod);
	}

	private function setUp():Void {
		instance = context.createEmptyMovieClip("test", context.getNextHighestDepth());
	}

	private function tearDown():Void {
		instance.removeMovieClip();
		instance = null;
	}

	public function testInstantiated():Void {
		assertTrue("MovieClip instantiated", instance instanceof MovieClip);
	}

	public function testAsyncMethod():Void {
		var handler:Function = addAsync(asyncHandler);
		Timer.setTimeout(this, handler, 100);
	}
	
	private function asyncHandler():Void {
		assertTrue(instance instanceof MovieClip);
	}
	
	public function testAsyncVisualEntity():Void {
		var handler:Function = addAsync(spriteHandler);
		Timer.setTimeout(this, handler, 100);
	}
	
	private function spriteHandler():Void {
		assertTrue(instance instanceof MovieClip);
	}
	
	public function testAsyncVisualEntity2():Void {
		var handler:Function = addAsync(spriteHandler);
		Timer.setTimeout(this, handler, 100);
	}
}
