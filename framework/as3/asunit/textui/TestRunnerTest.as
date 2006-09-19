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
			setTimeout(handler, 1000, new Event(Event.ACTIVATE));
		}
		
		public function asyncCompleteHandler(event:Event):void {
//			throw new IllegalOperationError("what the fuck?");
			fail("test async complete failed");
		}
		
		public function testSomethingComplete():void {
		}
		
		public function testSomethingElse():void {
		}
		
		public function testAnotherThing():void {
		}
	}
}
