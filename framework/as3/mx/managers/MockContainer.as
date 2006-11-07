package mx.managers {
	import mx.core.Container;

	public class MockContainer extends Container {

		override protected function commitProperties():void {
			super.commitProperties();
			trace("commit props");
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			trace("update display list");
		}
	}
}