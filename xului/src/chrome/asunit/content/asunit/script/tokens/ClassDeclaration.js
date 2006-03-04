
var ClassDeclaration = function() {
	this.interfaces = new Array();
	this.className = "";
}

ClassDeclaration.CLASS_KEYWORD = "class ";
ClassDeclaration.SUPERCLASS_KEYWORD = "extends ";
ClassDeclaration.INTERFACES_KEYWORD = "implements ";

ClassDeclaration.prototype = new Object();
ClassDeclaration.prototype.className;
ClassDeclaration.prototype.interfaces;
ClassDeclaration.prototype.superClass;

ClassDeclaration.prototype.addSuperClass = function(name) {
	this.superClass = name;
}

ClassDeclaration.prototype.clearInterfaces = function() {
	this.interfaces = new Array();
}

ClassDeclaration.prototype.addInterface = function(name) {
	var infName = name.split(".").pop();
	this.interfaces.push(infName);
}

ClassDeclaration.prototype.setClassName = function(name) {
	this.className = name;
}

ClassDeclaration.prototype.toString = function() {
	var str = "";
	str = ClassDeclaration.CLASS_KEYWORD;
	str += this.className + " ";

	if(this.superClass != null) {
		str += ClassDeclaration.SUPERCLASS_KEYWORD;
		str += this.superClass + " ";
	}

	if(this.interfaces.length > 0) {
		str += ClassDeclaration.INTERFACES_KEYWORD;

		var infSeparator = ", ";
		if(this.interfaces.length > 2) {
			infSeparator = ",\n";
			var ln = str.length;
			for(var i = 0; i < ln; i++) {
				infSeparator += " ";
			}
		}

		for(var i = 0; i < this.interfaces.length-1; i++) {
			str += this.interfaces[i] + infSeparator;
		}
		str += this.interfaces[i] + " ";
	}

	str += "{\n";

	return str;
}
