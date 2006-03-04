package asunit.example {
	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	import asunit.example.LivePreviewView;
	import asunit.example.LivePreviewModel;
	import flash.events.Event;

	public class LivePreviewModelMock extends LivePreviewModel {

		public function LivePreviewModelMock() {
		}
		
		public override function load():void {
			setContent(getMockContent());
			super.load();

			return;
			var event:Event = new Event(Event.COMPLETE);
			setContent(getMockContent());
			result = getMockData();
			completeHandler(event);
		}
		
		public function getMockContent():String {
			return "Italian sculptors and painters of the renaissance favored the Virgin Mary for inspiration.";
		}
		
		private function getMockData():XML {
			var data:XML = <ResultSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:yahoo:cate" xsi:schemaLocation="urn:yahoo:cate http://api.search.yahoo.com/ContentAnalysisService/V1/TermExtractionResponse.xsd">
							    <Result>italian sculptors</Result>
							    <Result>virgin mary</Result>
							    <Result>painters</Result>
							    <Result>renaissance</Result>
							    <Result>inspiration</Result>
						   </ResultSet>;
			return data;
		}
	}
}
