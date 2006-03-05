
class asunit.textui.SuccessBar extends MovieClip {
	public static var linkageId:String = "__Packages.asunit.textui.SuccessBar";
	public static var classRef:Function = SuccessBar;
	
	private var myWidth:Number = 0;
	private var myHeight:Number = 0;
	private var bgColor:Number;
	private var passingColor:Number = 0x00FF00;
	private var failingColor:Number = 0xFD0000;
	
	public function SuccessBar() {
	}
	
	public function setSuccess(success:Boolean):Void {
		bgColor = (success) ? passingColor : failingColor;
		draw();
	}

	public function set width(num:Number):Void {
		myWidth = num;
		draw();
	}

	public function set height(num:Number):Void {
		myHeight = num;
		draw();
	}

	private function draw():Void {
		clear();
		beginFill(bgColor);
		lineTo(myWidth, 0);
		lineTo(myWidth, myHeight);
		lineTo(0, myHeight);
		lineTo(0, 0);
		endFill();
	}
	
	public static var serializable:Boolean = Object.registerClass(linkageId, classRef);
}