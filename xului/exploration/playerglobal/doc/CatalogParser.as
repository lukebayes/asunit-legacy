
class CatalogParser {
	private var source:String = "catalog.xml";
	private var callback:Object;
	private var classNames:Array;

	public function CatalogParser() {
		init();
	}

	private function init():Void {
		classNames = new Array();
		getXML();
	}

	public function onComplete():Void {
		trace("--------------------");
//		trace("classNames: " + classNames);
		classNames.sort();
		var str:String = classNames.join("\n");
		trace(str);
	}

	public function addClass(name:String):Void {
		name = clean(name);
		var fullName:String = name;
		name = String(name.split(".").pop());

		classNames.push(name + "=" + fullName);
	}

	private function clean(name:String):String {
		return name.split(":").join(".");
	}

	private function getXML():Void {
		var xml:Object = new XML();
		xml.callback = this;
		xml.ignoreWhite = true;
		xml.onLoad = this.onLoaded;
		xml.load(source);
	}

	private function onLoaded(success):Void {
		this.callback.parseNode(this["firstChild"]);
		this.callback.onComplete();
	}

	private function parseNode(node:XMLNode):Void {
		var kids:Array = node.childNodes;
		for(var i = 0; i < kids.length; i++) {
			this["parse_" + kids[i].nodeName](kids[i]);
		}
	}

	private function parse_features(node:XMLNode):Void {
		trace("parsing features");
	}

	private function parse_components(node:XMLNode):Void {
		trace("parsing components");
//		parseNode(node);
	}

	private function parse_component(node:XMLNode):Void {
		trace("parsing component");
		addClass(node.attributes.className);
	}

	private function parse_libraries(node:XMLNode):Void {
		trace("parsing libraries");
		parseNode(node);
	}

	private function parse_library(node:XMLNode):Void {
		trace("parsing library");
		parseNode(node);
	}

	private function parse_script(node:XMLNode):Void {
//		trace("parsing script");
		parseNode(node);
	}

	private function parse_def(node:XMLNode):Void {
//		trace("parsing def");
		addClass(node.attributes.id);
	}
}