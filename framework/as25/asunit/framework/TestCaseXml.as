
import asunit.framework.TestCase;

class asunit.framework.TestCaseXml extends XML {
	public static var linkageId:String = "asunit.framework.TestCaseXml";
	public static var classRef:Function = TestCaseXml;

	private var source:String;
	private var callback:TestCase;

	public function TestCaseXml(src:String, cb:TestCase) {
		source = src;
		callback = cb;
		ignoreWhite = true;
		if(src != undefined) {
			load(source);
		}
	}

	public function onData(data:String):Void {
		if(data == "" || data == undefined) {
			callback.onXmlFailure(this);
		}
		else {
			super.onData(data);
		}
	}

	public function onLoad(success:Boolean):Void {
		if(success) {
			callback.onXmlLoaded(this.firstChild);
		} else {
			callback.onXmlFailure(this);
		}
	}

	public static var serializable:Boolean = Object.registerClass(linkageId, classRef);
}
