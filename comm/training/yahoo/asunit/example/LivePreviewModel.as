package asunit.example {
	import flash.util.trace;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoader;
	import flash.net.URLRequestHeader;
	import flash.events.Event;
	import flash.xml.XMLDocument;
	import flash.net.navigateToURL;

	public class LivePreviewModel extends EventDispatcher {
		public static var METHOD:String = "POST";
		protected var content:String;
		protected var response:XML;
		protected var appId:String = "asunit_search";
		protected var source:String = "http://api.search.yahoo.com/ContentAnalysisService/V1/termExtraction";
		
		public function LivePreviewModel() {
			response = new XML();
		}
		
		public function setContent(content:String):void {
			this.content = content;
		}
		
		public function load():void {
			var params:URLVariables = new URLVariables();
			params.appid = appId;
			params.context = content;
			var request:URLRequest = new URLRequest(source);
			request.method = "get";
			request.data = params;
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.load(request);
			trace("data loaded");
		}
		
		protected function completeHandler(event:Event):void {
			trace("complete handler fired");
			response = XML(event.target.data);
			dispatchEvent(event);
			trace("event dispatched with: " + response.toString());
		}
		
		public function getContent():String {
			return content;
		}
		
		public function getTerms():Array {
			var terms:Array = new Array();
			try {
				var data:XMLDocument = new XMLDocument();
				data.ignoreWhite = true;
				data.parseXML(response.toString());
				var kids:Array = data.firstChild.childNodes;
				for(var i:int; i < kids.length; i++) {
					terms.push(kids[i].firstChild.nodeValue);
				}
				trace("crap hole: " + terms);
			}
			catch(e:Error) {
				trace("ERROR: " + e.getStackTrace());
			}
			return terms;
		}
	}
}
