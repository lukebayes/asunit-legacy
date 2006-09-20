package asunit.textui {
	import asunit.framework.TestCase;
	import flash.utils.setTimeout;
	import flash.events.Event;
	import flash.errors.IllegalOperationError;

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
			assertTrue("TestRunner instantiated with: " + instance, instance is TestRunner);
		}

		public function testAsync():void {
			var handler:Function = addAsync(asyncCompleteHandler);
			setTimeout(handler, 400, new Event(Event.ACTIVATE));
		}
		
		public function asyncCompleteHandler(event:Event):void {
//			throw new IllegalOperationError("what the heck?");
		}
		
		public function testAsync2():void {
			var handler:Function = addAsync(async2CompleteHandler);
			setTimeout(handler, 40);
		}
		
		public function async2CompleteHandler():void {
//			fail("test async complete failed");
		}
		
		public function testSomethingComplete():void {
		}
		
		public function testSomethingElse():void {
		}
		
		public function testAnotherThing():void {
		}
	}
}
