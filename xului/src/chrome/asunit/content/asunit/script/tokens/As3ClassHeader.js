
var As3ClassHeader = function() {
}

As3ClassHeader.IMPORT_STATEMENT = "\timport ";

As3ClassHeader.prototype = new ClassHeader();
As3ClassHeader.prototype.package = "";

As3ClassHeader.prototype.setPackage = function(package) {
	this.package = package;
}

As3ClassHeader.prototype.toString = function() {
	var str = "package " + this.package + " {\n";
	var imports = this.imports;
	for(var i = 0; i < imports.length; i++) {
		str += As3ClassHeader.IMPORT_STATEMENT + imports[i] + ";\n";
	}
//	if(i > 0) {
		str += "\n";
//	}
	return str;
}
