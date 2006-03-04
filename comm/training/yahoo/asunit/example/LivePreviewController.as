package asunit.example {
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.Sprite;
	import asunit.example.LivePreviewView;
	import asunit.example.LivePreviewModel;
	import flash.events.KeyboardEvent;
	import flash.util.trace;
	import flash.ui.Keyboard;

	public class LivePreviewController {
		private var view:LivePreviewView;
		private var model:LivePreviewModel;
		
		public function LivePreviewController(view:LivePreviewView, model:LivePreviewModel) {
			this.view = view;
			this.model = model;
			this.view.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
			this.model.addEventListener(Event.COMPLETE, view.completeHandler);
//			this.model.addEventListener(Event.COMPLETE, view.completeHandler);
		}
		
		private function keyHandler(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.ENTER) {
				view.setOutputText("Request Pending...");
				model.setContent(view.getInputText());
				model.load();
			}
		}
	}
}
