
var TestCaseConfig = function() {
}

TestCaseConfig.prototype = new ClassSerializable();
TestCaseConfig.prototype.realClassName;
TestCaseConfig.prototype.isFactory = false;
TestCaseConfig.prototype.isVisual = false;
TestCaseConfig.prototype.isAsynchronous = false;

TestCaseConfig.prototype.setIsFactory = function(isFactory) {
	this.isFactory = isFactory;
}

TestCaseConfig.prototype.setIsAsynchronous = function(isAsynchronous) {
	this.isAsynchronous = isAsynchronous;
}

TestCaseConfig.prototype.setIsVisual = function(isVisual) {
	this.isVisual = isVisual;
}

TestCaseConfig.prototype.setRealClassName = function(name) {
	this.realClassNameFull = name;
	this.realClassName = name.split(".").pop();
}

TestCaseConfig.prototype.toString = function() {
	var str = "";
	str += "\tprivate var className:String = \"" + this.getLinkage() + "\";\n";
	str += "\tprivate var instance:" + this.realClassName + ";\n";

	if(this.isAsynchronous) {
		str += "\tprivate var xmlData:TestCaseXml;\n\n";
		str += "\tpublic function run():Void {\n";
		str += "\t\txmlData = new TestCaseXml(\"pathToYourXmlFile.xml\", this);\n";
		str += "\t}\n\n";
		str += "\tpublic function onXmlLoaded(node:XMLNode):Void {\n";
		str += "\t\tsuper.run();\n";
		str += "\t}\n";
	}

	str += "\n"
	str += "\tpublic function setUp():Void {\n";

	if(this.isAsynchronous) {
		str += "\t\tvar data:XMLNode = xmlData.cloneNode(true);\n";
	}


	if(this.isFactory) {
		str += "\t\tinstance = " + this.realClassName + ".create();\n";
	} else if(this.isVisual) {
		str += "\t\tvar initObj:Object = new Object();\n";
		str += "\t\tinstance = " + this.realClassName + "(attachMovie(" + this.realClassName + ".linkageId, initObj));\n";
	} else {
		str += "\t\tinstance = new " + this.realClassName + "();\n";
	}

	str += "\t}\n\n";
	str += "\tpublic function tearDown():Void {\n";

	if(this.isFactory) {
		str += "\t\t" + this.realClassName + ".destroy();\n";
	} else if(this.isVisual) {
		str += "\t\tinstance.removeMovieClip();\n";
	}
	str += "\t\tdelete instance;\n";

	str += "\t}\n\n";
	str += "\tpublic function testInstantiated():Void {\n";
	str += "\t\tassertTrue(\"" + this.realClassName + " instantiated\", instance instanceof " + this.realClassName + ");\n";
	str += "\t}\n\n";
	str += "\tpublic function test():Void {\n";
	str += "\t\tassertTrue(\"failing test\", false);\n";
	str += "\t}";
	return str;
}
