package asunit.textui {
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.core.IUIComponent;
	
	public class FlexTestRunner extends TestRunner {

		protected override function addedHandler(event:Event):void {
			if(event.target === this) {
				parent.addEventListener(Event.RESIZE, resizeHandler);
			}
		}
		
		public override function set width(w:Number):void {
			fPrinter.width = w;
		}

		public override function set height(h:Number):void {
			fPrinter.height = h;
		}
		
		private function resizeHandler(event:Event):void {
			width = event.target.width;
			height = event.target.height;
		}
		
		public override function addChild(child:DisplayObject):DisplayObject {
			if(parent) {
				return parent.addChild(child);
			}
			else {
				return super.addChild(child);
			}
		}
	}		
}