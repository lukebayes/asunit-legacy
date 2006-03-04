
var StubEntity = function(name, className) {
	this.init(name, className);
}

StubEntity.prototype = new Object();

StubEntity.prototype.name				= "";
StubEntity.prototype.fullPath 			= "";
StubEntity.prototype.classPath 			= "";
StubEntity.prototype.className 			= "";
StubEntity.prototype.lowerCaseClassName = "";
StubEntity.prototype.isInterface 		= false;

StubEntity.prototype.init = function(name, className) {
	this.name = name;
	this.className = className;
}

StubEntity.prototype.getName = function() {
	return this.name;
}

StubEntity.prototype.getFullPath = function() {
	return this.className;
}

StubEntity.prototype.getLowerCaseClassName = function() {
	if(this.lowerCaseClassName == "") {
		this.lowerCaseClassName = this.className.toLowerCase();
	}
	return this.lowerCaseClassName;
}

StubEntity.prototype.setLowerCaseClassName = function(str) {
	this.lowerCaseClassName = str.toLowerCase();
}

StubEntity.prototype.getClassName = function() {
	return this.className;
}

StubEntity.prototype.toString = function() {
	return this.getName();
}
