package asunit.textui {
	import mx.core.IUIComponent;
	import flash.events.Event;
	import asunit.runner.Version;
	
	public class FlexTestRunner extends TestRunner {

		protected override function addedHandler(event:Event):void {
			if(event.target === this) {
				parent.addEventListener(Event.RESIZE, resizeHandler);
				fPrinter.println("AsUnit " + Version.id() + " by Luke Bayes and Ali Mills");
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
	}		
}