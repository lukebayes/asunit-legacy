package asunit.example {
	import asunit.framework.TestCase;
	import flash.util.trace;

	public class LivePreviewViewTest extends TestCase {
		private var instance:LivePreviewView;
		private var instanceWidth:Number = 800;
		private var instanceHeight:Number = 300;

		public function LivePreviewViewTest(testMethod:String = null) {
			super(testMethod);
		}

		protected override function setUp():void {
			instance = new LivePreviewView();
			instance.setWidth(instanceWidth);
			instance.setHeight(instanceHeight);
			addChild(instance);
		}

		protected override function tearDown():void {
			removeChild(instance);
			delete instance;
		}

		public function testInstantiated():void {
			assertTrue("LivePreviewView instantiated", instance is LivePreviewView);
		}

		public function testWidth():void {
			assertTrue("width: " + instance.getWidth(), instance.getWidth() == instanceWidth);
		}
		
		public function testHeight():void {
			assertTrue("height: " + instance.getHeight(), instance.getHeight() == instanceHeight);
		}
	}
}
