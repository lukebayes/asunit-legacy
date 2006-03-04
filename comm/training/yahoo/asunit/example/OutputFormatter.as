package asunit.example {
	import flash.util.trace;
	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	import asunit.example.LivePreviewView;
	import asunit.example.LivePreviewModel;

	public class OutputFormatter {
		private var content:String;
		private var formatted:String;
		private var terms:Array;

		public function OutputFormatter(content:String, terms:Array) {
			formatted = content.toLowerCase(); // shameless hack!
			var ln:int = terms.length;
			for(var i:int; i < ln; i++) {
				formatted = formatted.split(terms[i]).join(buildUrl(terms[i]));
			}
		}
		
		private function buildUrl(term:String):String {
			var str:String = "<a href='http://search.yahoo.com/search?p=" + encodeURI(term) + "'><u><b><font color='#0000FF'>" + term + "</font></b></u></a>";
			trace("str: " + str);
			return str;
		}
		
		public function getFormatted():String {
			return formatted;
		}
	}
}
