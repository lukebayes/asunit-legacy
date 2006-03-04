
var As3ClassDeclaration = function() {
	this.interfaces = new Array();
	this.className = "";
}

As3ClassDeclaration.prototype = new ClassDeclaration();

As3ClassDeclaration.CLASS_KEYWORD = "\tpublic class ";
As3ClassDeclaration.SUPERCLASS_KEYWORD = "extends ";
As3ClassDeclaration.INTERFACES_KEYWORD = "implements ";

As3ClassDeclaration.prototype.setClassName = function(name) {
	this.className = name.split(".").pop();
}

As3ClassDeclaration.prototype.toString = function() {
	var str = "";
	str += As3ClassDeclaration.CLASS_KEYWORD;
	str += this.className + " ";

	if(this.superClass != null) {
		str += As3ClassDeclaration.SUPERCLASS_KEYWORD;
		str += this.superClass + " ";
	}

	if(this.interfaces.length > 0) {
		str += As3ClassDeclaration.INTERFACES_KEYWORD;

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
