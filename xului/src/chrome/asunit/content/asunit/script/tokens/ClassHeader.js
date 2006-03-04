
var ClassHeader = function() {
	this.imports = new Array();
}

ClassHeader.IMPORT_STATEMENT = "import ";

ClassHeader.prototype = new Object();
ClassHeader.prototype.imports;

ClassHeader.prototype.addImport = function(fullTarget) {
	if(!this.hasImport(fullTarget)) {
		this.imports.push(fullTarget);
	}
}

ClassHeader.prototype.removeImport = function(fullTarget) {
	this.hasImport(fullTarget, true);
}

ClassHeader.prototype.removeAllImports = function() {
	this.imports = new Array();
}

ClassHeader.prototype.hasImport = function(fullTarget, remove) {
	for(var i = 0; i < this.imports.length; i++) {
		if(this.imports[i] == fullTarget) {
			if(remove) {
				this.imports.splice(i, 1);
			}
			return true;
		}
	}
	return false;
}

ClassHeader.prototype.toString = function() {
	var str = "\n";
	var imports = this.imports;
	for(var i = 0; i < imports.length; i++) {
		str += ClassHeader.IMPORT_STATEMENT + imports[i] + ";\n";
	}
	if(i > 0) {
		str += "\n";
	}
	return str;
}
