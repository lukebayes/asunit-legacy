package asunit.framework {
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import flash.errors.IllegalOperationError;
	
	
	public class TestCaseTest extends TestCase {
		
		public function TestCaseTest(testMethod:String = null) {
			super(testMethod);
		}
		
		public function testInstantiated():void {
			assertTrue(this is TestCase);
		}
		
		public function testCustomConstructor():void {
			var mock:TestCaseMock = new TestCaseMock("testMethod1");
			mock.run();
			assertTrue("testMethod1Run", mock.testMethod1Run);
			assertFalse("testMethod2Run", mock.testMethod2Run);
			assertFalse("testMethod3Run", mock.testMethod3Run);
		}
		
		public function testCustomConstructor2():void {
			var mock:TestCaseMock = new TestCaseMock("testMethod1, testMethod3");
			mock.run();
			assertTrue("testMethod1Run", mock.testMethod1Run);
			assertFalse("testMethod2Run", mock.testMethod2Run);
			assertTrue("testMethod3Run", mock.testMethod3Run);
		}

		public function testCustomConstructor3():void {
			var mock:TestCaseMock = new TestCaseMock("testMethod1,testMethod3");
			mock.run();
			assertTrue("testMethod1Run", mock.testMethod1Run);
			assertFalse("testMethod2Run", mock.testMethod2Run);
			assertTrue("testMethod3Run", mock.testMethod3Run);
		}

		public function testCustomConstructor4():void {
			var mock:TestCaseMock = new TestCaseMock("testMethod1, testMethod2,testMethod3");
			mock.run();
			assertTrue("testMethod1Run", mock.testMethod1Run);
			assertTrue("testMethod2Run", mock.testMethod2Run);
			assertTrue("testMethod3Run", mock.testMethod3Run);
		}

		public function testAsync():void {
			trace("TEST ASYNC");
			var dispatcher:EventDispatcher = new EventDispatcher();
			var handler:Function = addAsync(asyncHandler, 400);
			trace("METHOD IS ASYNC? : " + methodIsAsynchronous);
			dispatcher.addEventListener(Event.COMPLETE, handler);
			setTimeout(dispatcher.dispatchEvent, 200, new Event(Event.COMPLETE));
		}
		
		private function asyncHandler(event:Event):void {
			assertEquals(event.type, Event.COMPLETE);
//			assertTrue(false);
//			throw new IllegalOperationError("broken");
		}
	}
}