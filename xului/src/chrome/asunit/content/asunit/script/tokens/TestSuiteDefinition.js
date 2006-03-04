
var TestSuiteDefinition = function() {
	this.items = new Array();
}

TestSuiteDefinition.prototype = new Object();
TestSuiteDefinition.prototype.items;
TestSuiteDefinition.prototype.name;
TestSuiteDefinition.prototype.location;

TestSuiteDefinition.prototype.setName = function(name) {
	if(name.substr(0,1) == ".") {
		name = name.substr(1);
	}
	this.name = name;
}

TestSuiteDefinition.prototype.setLocation = function(dir) {
	this.location = dir;
}

TestSuiteDefinition.prototype.addItem = function(item) {
	this.items.push(item);
}

TestSuiteDefinition.prototype.toString = function() {
	var str = "\n";
	str += "class " + this.name + " extends com.asunit.framework.TestSuite {\n";
	str += "\tprivate var className:String = \"" + this.name + "\";\n\n";
	str += "\tpublic function AllTests() {\n";
	str += "\t\tsuper();\n";
	for(var i = 0; i < this.items.length; i++) {
		str += "\t\taddTest(new " + this.items[i] + "());\n";
	}
	str += "\t}\n";
	str += "}\n";

	return str;
}
