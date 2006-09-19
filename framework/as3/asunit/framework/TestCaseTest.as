package asunit.framework {
	
	public class TestCaseTest extends TestCase {
		
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
	}
}