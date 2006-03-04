
var As3TestCaseConstructor = function() {
}

As3TestCaseConstructor.prototype = new Object();
As3TestCaseConstructor.prototype.className;

As3TestCaseConstructor.prototype.setClassName = function(className) {
	this.className = className;
}


As3TestCaseConstructor.prototype.toString = function() {
	var str = "\n";
	str += "\t\tpublic function " + this.className + "(testMethod:String = null) {\n";
	str += "\t\t\tsuper(testMethod);\n";
	str += "\t\t}\n";
	return str;
}
