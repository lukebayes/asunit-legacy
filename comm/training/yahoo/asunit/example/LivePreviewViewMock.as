package asunit.example {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	import asunit.example.LivePreviewView;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class LivePreviewViewMock extends LivePreviewView {

		public function LivePreviewViewMock() {
		}
		
		public function getOutputText():String {
			return output.htmlText;
		}
		
		public function triggerKeyHandler(keyCode:Number):void {
			var event:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_UP);
			event.keyCode = keyCode;
			dispatchEvent(event);
		}
		
		public function mockCompleteHandler(event:Event):void {
			completeHandler(event);
		}
	}
}
