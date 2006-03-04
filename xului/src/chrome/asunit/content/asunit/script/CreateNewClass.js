
var CreateNewClass = function(workingDirName, fullClassName, fileString) {
	this.fileString = fileString;
	var file = new AsFile();
	this.workingDir = file.open(workingDirName);
	this.writeFile(this.workingDir, fullClassName);
}

CreateNewClass.prototype = new Object();
CreateNewClass.prototype.fileString;
CreateNewClass.prototype.workingDirName;
CreateNewClass.prototype.workingDir;
CreateNewClass.prototype.success;
CreateNewClass.prototype.path;

CreateNewClass.prototype.writeFile = function(parent, dotName) {
	parent.QueryInterface(Components.interfaces.nsIFile);

	var arr = dotName.split(".");
	if(arr.length > 1) {
		var dirName = arr.shift();
		dotName = arr.join(".");
		parent.append(dirName);
		this.writeFile(parent, dotName);
	} else {
		var fileName = dotName + CreateClass.ACTIONSCRIPT_SUFFIX;
		var writtenFile = new WrittenFile(parent, fileName, this.fileString);
		this.onCompleted(writtenFile);
	}
}

CreateNewClass.prototype.onCompleted = function(file) {
	this.success = file.success;
	this.path = file.path;
}
