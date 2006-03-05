
var As25TestCaseConstructor = function() {
}

As25TestCaseConstructor.prototype = new Object();
As25TestCaseConstructor.prototype.className;

As25TestCaseConstructor.prototype.setClassName = function(className) {
	this.className = className;
}


As25TestCaseConstructor.prototype.toString = function() {
	var str = "\n";
	str += "\tpublic function " + this.className + "(testMethod:String) {\n";
	str += "\t\tsuper(testMethod);\n";
	str += "\t}\n";
	return str;
}
