package asunit.textui {
	import mx.core.IUIComponent;
	import flash.events.Event;
	import asunit.runner.Version;
	
	public class FlexTestRunner extends TestRunner implements IUIComponent {

		private function onAdded(event:Event):void {
			fPrinter.println("AsUnit " + Version.id() + " by Luke Bayes and Ali Mills"); 
		}
		
		public override function set width(w:Number):void {
			fPrinter.width = w;
		}

		public override function set height(h:Number):void {
			fPrinter.height = h;
		}
	}		
}