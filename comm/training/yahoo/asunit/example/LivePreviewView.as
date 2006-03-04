package asunit.example {
	import flash.util.trace;
	import flash.display.Sprite;
	import flash.display.TextField;
	import flash.display.TextFieldType;
	import flash.text.TextFormat;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import asunit.example.LivePreviewModel;
	import asunit.example.OutputFormatter;

	public class LivePreviewView extends Sprite {
		private var bgColor:int = 0xFFFFFF;
		private var $width:int = 900;
		private var $height:int = 350;
		protected var input:TextField;
		protected var output:TextField;
		protected var model:EventDispatcher;
		
		public function LivePreviewView() {
			configureAssets();
			draw();
		}
		
		private function configureAssets():void {
			input = createEmptyTextField();
			output = createEmptyTextField();
			output.type = TextFieldType.DYNAMIC;
			output.html = true;
			addChild(input);
			addChild(output);
			
			setWidth($width);
			setHeight($height);
		}
		
		public function completeHandler(event:Event):void {
			var unformatted:String = event.target.getContent();
			var terms:Array = event.target.getTerms();
			trace("terms: " + terms.toString());
			trace("unformatted: " + unformatted);
			var formatter:OutputFormatter = new OutputFormatter(unformatted, terms);
			setOutputText(formatter.getFormatted());
		}
		
		public function getInputText():String {
			return input.text;
		}
		
		public function setOutputText(text:String):void {
			output.htmlText = text;
		}

		private function createEmptyTextField():TextField {
			var text:TextField = new TextField();
			text.background = true;
			text.border = true;
			text.multiline = true;
			text.wordWrap = true;
			text.type = TextFieldType.INPUT;
			var format:TextFormat = new TextFormat();
			format.size = 14;
			format.font = "Verdana";
			text.defaultTextFormat = format;
			return text;
		}
		
		public function draw():void {
			graphics.clear();
			graphics.beginFill(bgColor);
			graphics.drawRect(0, 0, $width, $height);
			graphics.endFill();
		}
		
		public function setWidth(num:Number):void {
			$width = Math.round(num);
			input.width = $width / 2;
			output.width = $width / 2;
			output.x = input.width;
			draw();
		}
		
		public function getWidth():int {
			input.height = $height;
			output.height = $height;
			return width;
		}
		
		public function setHeight(num:Number):void {
			$height = Math.round(num);
			input.height = $height;
			output.height = $height;
			draw();
		}
		
		public function getHeight():int {
			return height;
		}
	}
}
