
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
		onLoad = loadHandler;
		if(src != undefined) {
			load(source);
		}
	}

	public function loadHandler(success:Boolean):Void {
		if(success) {
			callback.onXmlLoaded(this.firstChild);
		} else {
			trace("Error: TestCaseXml Failed to load data at: " + source);
			callback.onXmlFailure(this);
		}
	}

	public static var serializable:Boolean = Object.registerClass(linkageId, classRef);
}
