
var Entity = function(file, cp) {
	this.init(file, cp);
}

Entity.prototype = new Object();

Entity.prototype.file;
Entity.prototype.name;
Entity.prototype.fullPath;
Entity.prototype.classPath;
Entity.prototype.className;
Entity.prototype.lowerCaseClassName;
Entity.prototype.isInterface;

Entity.prototype.init = function(file, cp) {
	this.classPath = cp;
	this.setFile(file);
}

Entity.prototype.setName = function(str) {
	var arr = str.split(".");
	this.name = arr[0];
}

Entity.prototype.getName = function() {
	return this.name;
}

Entity.prototype.setFullPath = function(str) {
	this.fullPath = str;
}

Entity.prototype.getFullPath = function() {
	return this.fullPath;
}

Entity.prototype.setFile = function(file) {
	this.file = file;
	this.setFullPath(file.path);
	this.setName(file.leafName);
}

Entity.prototype.getLowerCaseClassName = function() {
	if(this.lowerCaseClassName == null) {
		this.getClassName();
	}
	return this.lowerCaseClassName;
}

Entity.prototype.setLowerCaseClassName = function(str) {
	this.lowerCaseClassName = str.toLowerCase();
}

Entity.prototype.getClassName = function() {
	if(this.className == null) {
		var index = this.classPath.length+1;
		var str = this.fullPath.substring(index);
		str = str.substr(0, str.indexOf("."));
		this.className = str.split(CreateClass.FILE_SEPARATOR).join(".");
		this.setLowerCaseClassName(this.className);
	}
	return this.className;
}

Entity.prototype.isTestCase = function() {

}

Entity.prototype.toString = function() {
	return this.getName();
}
