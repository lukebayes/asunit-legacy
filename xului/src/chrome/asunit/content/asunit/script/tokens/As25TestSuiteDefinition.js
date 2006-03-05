
var As25TestSuiteDefinition = function() {
	this.items = new Array();
}

As25TestSuiteDefinition.prototype = new Object();
As25TestSuiteDefinition.prototype.items;
As25TestSuiteDefinition.prototype.name;
As25TestSuiteDefinition.prototype.location;

As25TestSuiteDefinition.prototype.setName = function(name) {
	if(name.substr(0,1) == ".") {
		name = name.substr(1);
	}
	this.name = name;
}

As25TestSuiteDefinition.prototype.setLocation = function(dir) {
	this.location = dir;
}

As25TestSuiteDefinition.prototype.addItem = function(item) {
	this.items.push(item);
}

As25TestSuiteDefinition.prototype.toString = function() {
	var str = "\n";
	str += "class " + this.name + " extends asunit.framework.TestSuite {\n";
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
