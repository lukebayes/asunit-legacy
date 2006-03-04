package asunit.example {
	import flash.util.trace;
	import asunit.framework.TestCase;
	import flash.events.IEventDispatcher;
	import asunit.example.LivePreviewModelMock;
	import asunit.example.LivePreviewViewMock;
	import flash.events.Event;

	public class LivePreviewModelTest extends TestCase {
		private var instance:LivePreviewModelMock;
		private var view:LivePreviewViewMock;

		public function LivePreviewModelTest(testMethod:String = null) {
			super(testMethod);
		}

		protected override function setUp():void {
			view = new LivePreviewViewMock();
			addChild(view);
			instance = new LivePreviewModelMock();
		}
		
		protected override function tearDown():void {
			removeChild(view);
			delete view;
			delete instance;
		}

		public function testInstantiated():void {
			assertTrue("LivePreviewModel instantiated", instance is LivePreviewModel);
		}

		public function testSetContent():void {
			var content:String = instance.getMockContent();
			instance.setContent(content);
			assertTrue("setContent worked", instance.getContent() == content);
		}
		
		public function testIsEventDispatcher():void {
			assertTrue(instance is IEventDispatcher);
		}
		
		public function testLoad():void {
			instance.addEventListener(Event.COMPLETE, view.mockCompleteHandler);
			instance.load();
		}
	}
}
