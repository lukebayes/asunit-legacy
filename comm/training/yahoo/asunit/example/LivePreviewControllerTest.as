package asunit.example {
	import asunit.framework.TestCase;
	import asunit.example.LivePreviewView;
	import asunit.example.LivePreviewModel;
	import flash.ui.Keyboard;

	public class LivePreviewControllerTest extends TestCase {
		private var instance:LivePreviewController;
		private var view:LivePreviewViewMock;
		private var model:LivePreviewModel;

		public function LivePreviewControllerTest(testMethod:String = null) {
			super(testMethod);
		}

		protected override function setUp():void {
			view = new LivePreviewViewMock();
			model = new LivePreviewModelMock();
			instance = new LivePreviewController(view, model);
		}

		protected override function tearDown():void {
			delete instance;
			delete view;
			delete model;
		}

		public function testInstantiated():void {
			assertTrue("LivePreviewController instantiated", instance is LivePreviewController);
		}

		public function testKeyHandler():void {
			view.triggerKeyHandler(Keyboard.ENTER);
//			assertTrue(model.getContent() == view.getInputText());
		}
	}
}
