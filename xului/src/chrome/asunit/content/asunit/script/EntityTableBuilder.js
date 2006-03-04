
var EntityTableBuilder = function(model) {
	this.init(model);
}

EntityTableBuilder.prototype = new Object();
EntityTableBuilder.prototype.ignoreExpressions;
EntityTableBuilder.prototype.table;
EntityTableBuilder.prototype.basePath;
EntityTableBuilder.prototype.nameList;
EntityTableBuilder.prototype.ignoreList;
EntityTableBuilder.prototype.pathList;

EntityTableBuilder.prototype.init = function(model) {
	this.ignoreList = this.buildIgnoreList();
	this.table = new EntityTable();
	this.nameList = new Array();
	this.pathList = new Array();

	var template = model.getTemplate();
	var items = new Array();
	if(template == "as3") {
		var arr = new As3Entities();
		items = arr.getItems();
	}
	else if(template == "as25") {
		var arr = new As25Entities();
		items = arr.getItems();
	}
	else {
		var arr = new As2Entities();
		items = arr.getItems();
	}
	var ln = items.length;
	for(var i = 0; i < ln; i++) {
		this.nameList.push(items[i].getName());
		this.table.addItem(items[i]);
	}
}

EntityTableBuilder.prototype.addPath = function(path) {
	if(path != "" && path != null && path != undefined) {
		this.pathList.push(path);
	}
}

EntityTableBuilder.prototype.buildIgnoreList = function() {
	return CreateClass.IGNORE_EXPRESSIONS.split(" ");
}

EntityTableBuilder.prototype.ignoreFile = function(ref) {
	var arr = this.ignoreList;
	for(var i in arr) {
		if(ref.leafName.indexOf(arr[i]) > -1) {
			return true;
		}
	}
	return false;
}

EntityTableBuilder.prototype.openDir = function(path) {
	var asFile = new AsFile();
	var dir = asFile.open(path);
	var isDir = dir.isDirectory();
	this.parseDir(dir);
}

EntityTableBuilder.prototype.parseDir = function(dir) {
	var entries = dir.directoryEntries;
	try {
		while(entries.hasMoreElements())
		{
			var entry = entries.getNext();
			entry.QueryInterface(Components.interfaces.nsIFile);
			if(this.ignoreFile(entry)) {
				continue;
			}

			if(this.isIncludedFile(entry)) {
				this.nameList.push(entry);
				this.table.addItem(new Entity(entry, this.basePath));
			}
			if(entry.isDirectory()) {
				this.parseDir(entry);
			}
		}
	} catch(e) {
		alert(">> exception caught: " + e.toString());
	}
}

EntityTableBuilder.prototype.isIncludedFile = function(file) {
	// TODO: Change this functionality to use a regular expression
	// rather than an indexOf search...
	return (file.leafName.indexOf(CreateClass.FILE_EXPRESSION) > -1);
}

EntityTableBuilder.prototype.getTable = function() {
	for(var i = 0; i < this.pathList.length; i++) {
		this.basePath = this.pathList[i];
		this.openDir(this.basePath);
	}
	this.table.sort();
	//alert(">> returning table with: " + this.table.toString());
	return this.table;
}

//var path = "C:\\cygwin\\home\\lbayes\\projects\\fluid\\fluid-svn\\build"
//var entityTableBuilder = new EntityTableBuilder(path);
