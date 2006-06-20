
var As3TestCaseConfig = function() {
	this.constr = new As3TestCaseConstructor();
}

As3TestCaseConfig.prototype = new ClassSerializable();
As3TestCaseConfig.prototype.realClassName;
As3TestCaseConfig.prototype.isFactory = false;
As3TestCaseConfig.prototype.isVisual = false;
As3TestCaseConfig.prototype.isAsynchronous = false;
As3TestCaseConfig.prototype.constr;


As3TestCaseConfig.prototype.setIsFactory = function(isFactory) {
	this.isFactory = isFactory;
}

As3TestCaseConfig.prototype.setIsAsynchronous = function(isAsynchronous) {
	this.isAsynchronous = isAsynchronous;
}

As3TestCaseConfig.prototype.setIsVisual = function(isVisual) {
	this.isVisual = isVisual;
}

As3TestCaseConfig.prototype.setRealClassName = function(name) {
	this.realClassNameFull = name;
	this.realClassName = name.split(".").pop();
}

As3TestCaseConfig.prototype.setClassName = function(fullName) {
	this.fullName = fullName;
	this.className = fullName.split(".").pop();
	this.constr.setClassName(this.className);
}

As3TestCaseConfig.prototype.toString = function() {
	var str = "";
//	str += "\tprivate var className:String = \"" + this.getLinkage() + "\";\n";
	str += "\t\tprivate var instance:" + this.realClassName + ";\n";

	str += this.constr.toString();

	if(this.isAsynchronous) {
		str += "\t\tprivate var source:String = \"[URI to source data here]\";\n";
		str += "\t\tprivate var dataSource:XML;\n\n";

//		str += "\t\tprivate var xmlData:TestCaseXml;\n\n";
		str += "\t\tpublic override function run():void {\n";
		str += "\t\t\tvar request:URLRequest = new URLRequest(source);\n";
		str += "\t\t\tvar loader:URLLoader = new URLLoader();\n";
		str += "\t\t\tconfigureListeners(loader);\n";
		str += "\t\t\tloader.load(request);\n";
		str += "\t\t}\n\n";

		str += "\t\tprotected override function completeHandler(event:Event):void {\n";
		str += "\t\t\tdataSource = XML(event.target.data).copy();\n";
		str += "\t\t\tsuper.run();\n";
		str += "\t\t}\n\n";
	}

	str += "\n"
	str += "\t\tprotected override function setUp():void {\n";

	if(this.isAsynchronous) {
		str += "\t\t\t//Always copy() the XML data so that you don't corrupt subsequent tests.\n";
		str += "\t\t\tvar data:XML = dataSource.copy();\n";
	}


	if(this.isFactory) {
		str += "\t\t\tinstance = " + this.realClassName + ".create();\n";
	} else {
		str += "\t\t\tinstance = new " + this.realClassName + "();\n";
	}

	if(this.isVisual) {
		str += "\t\t\taddChild(instance);\n";
	}

	str += "\t\t}\n\n";
	str += "\t\tprotected override function tearDown():void {\n";

	if(this.isFactory) {
		str += "\t\t\t" + this.realClassName + ".destroy();\n";
	} else if(this.isVisual) {
		str += "\t\t\tremoveChild(instance);\n";
	}
	str += "\t\t\tinstance = null;\n";

	str += "\t\t}\n\n";
	str += "\t\tpublic function testInstantiated():void {\n";
	str += "\t\t\tassertTrue(\"" + this.realClassName + " instantiated\", instance is " + this.realClassName + ");\n";
	str += "\t\t}\n\n";
	str += "\t\tpublic function test():void {\n";
	str += "\t\t\tassertTrue(\"failing test\", false);\n";
	str += "\t\t}";
	return str;
}
