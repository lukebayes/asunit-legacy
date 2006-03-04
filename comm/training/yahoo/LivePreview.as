package {
	import flash.display.Sprite;
	import flash.util.trace;
	import asunit.example.LivePreviewController;
	import asunit.example.LivePreviewView;
	import asunit.example.LivePreviewModel;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class LivePreview extends Sprite {
		private var controller:LivePreviewController;
		private var view:LivePreviewView;
		private var model:LivePreviewModel;
		
		public function LivePreview() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			configure();
		}
		
		private function configure():void {
			model = new LivePreviewModel();
			view = new LivePreviewView();
			addChild(view);
			controller = new LivePreviewController(view, model);
			stage.addEventListener(Event.RESIZE, resizeHandler);
			resizeHandler();
		}
		
		private function resizeHandler(event:Event = null):void {
			view.setWidth(stage.stageWidth);
			view.setHeight(stage.stageHeight);
		}
	}
}
