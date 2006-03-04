
var ClassSerializable = function() {
}

ClassSerializable.prototype = new Object();
ClassSerializable.prototype.className;
ClassSerializable.prototype.fullName;
ClassSerializable.prototype.addPackagesPrefix;

ClassSerializable.prototype.setAddPackages = function(shouldAdd) {
	this.addPackagesPrefix = shouldAdd;
}

ClassSerializable.prototype.getAddPackages = function() {
	return this.addPackagesPrefix;
}

ClassSerializable.prototype.setClassName = function(fullName) {
	this.fullName = fullName;
	this.className = fullName.split(".").pop();
}

ClassSerializable.prototype.getLinkage = function() {
	var str = "";
	if(this.addPackagesPrefix) {
		str += "__Packages.";
	}
	return str += this.fullName;

}

ClassSerializable.prototype.getIntroduction = function() {
	var str = "";
	str += "\tpublic static var linkageId:String = \"" + this.getLinkage() + "\";\n";
	str += "\tpublic static var classRef:Function = " + this.className + ";\n";
	return str;
}

ClassSerializable.prototype.getConclusion = function() {
	var str = "";
	str += "\n\tpublic static var serializable:Boolean = Object.registerClass(linkageId, classRef);";
	return str;
}



