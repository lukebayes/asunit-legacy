
var AsFile = function(filePath) {
	if(filePath != null) {
		this.open(filePath);
	}
}

AsFile.prototype = new Object();
AsFile.prototype.file;

AsFile.prototype.isDirectory = function() {
	return this.file.isDirectory();
}

AsFile.prototype.open = function(filePath) {
	this.file = Components.classes["@mozilla.org/file/local;1"].createInstance(Components.interfaces.nsILocalFile);
	this.file.initWithPath(filePath);
	return this.file;
}
