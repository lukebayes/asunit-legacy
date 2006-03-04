package  {
	import flash.events.EventDispatcher;
	import asunit.textui.TestRunner;
	import flash.system.fscommand;
	import asunit.example.LivePreviewViewTest;
	import asunit.example.LivePreviewModelTest;

	public class LivePreviewRunner extends TestRunner {

		public function LivePreviewRunner() {
			fscommand("fullscreen", "true");
			start(LivePreviewModelTest, "testLoad");
//			start(LivePreviewViewTest, "testWidth");
//			start(AllTests);
		}
	}
}
