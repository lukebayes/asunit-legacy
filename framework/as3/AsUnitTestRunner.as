package {
	import asunit.textui.TestRunner;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.fscommand;
	
	public class AsUnitTestRunner extends TestRunner {

		public function AsUnit() {
			fscommand("fullscreen", "true");
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			start(AllTests);
		}
	}
}
