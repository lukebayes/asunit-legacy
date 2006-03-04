
var As3TestSuiteDefinition = function() {
	this.items = new Array();
}

As3TestSuiteDefinition.prototype = new Object();
As3TestSuiteDefinition.prototype.items;
As3TestSuiteDefinition.prototype.name;
As3TestSuiteDefinition.prototype.location;
As3TestSuiteDefinition.prototype.package = "";


As3TestSuiteDefinition.prototype.setName = function(name) {
	var arr = name.split(".");
	this.name = arr.pop();
	if(arr[0] == "") {
		arr.shift();
	}

	if(arr.length > 0) {
		this.package = arr.join(".") + " ";
	}
}

As3TestSuiteDefinition.prototype.setLocation = function(dir) {
	this.location = dir;
}

As3TestSuiteDefinition.prototype.addItem = function(item) {
	this.items.push(item);
}

As3TestSuiteDefinition.prototype.toString = function() {
	var str = "";
	str += "package " + this.package + "{\n";
	str += "\timport asunit.framework.TestSuite;\n";
	// THIS IS STUPID! IS IT A BUG IN AS3 COMPILER? RUNTIME?
	for(var i = 0; i < this.items.length; i++) {
		str += "\timport " + this.items[i] + ";\n";
	}
	str += "\n";

	str += "\tpublic class " + this.name + " extends TestSuite {\n\n";
	str += "\t\tpublic function AllTests() {\n";
	for(var i = 0; i < this.items.length; i++) {
		str += "\t\t\taddTest(new " + this.items[i] + "());\n";
	}
	str += "\t\t}\n";
	str += "\t}\n";
	str += "}\n";

	return str;
}
