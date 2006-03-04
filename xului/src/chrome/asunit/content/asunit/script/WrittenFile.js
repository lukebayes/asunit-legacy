
var WrittenFile = function(parent, fileName, fileString) {
	this.fileString = fileString;
	this.writeFile(parent, fileName);
}

WrittenFile.prototype.success = false;
WrittenFile.prototype.path;

WrittenFile.prototype.writeFile = function(parent, fileName) {
	parent.QueryInterface(Components.interfaces.nsIFile);

	try {
		parent.append(fileName);
		parent.create(CreateClass.NORMAL_FILE_TYPE, CreateClass.LINUX_PERMISSIONS);
		this.writeContents(parent);
	} catch(e) {
		if(e.name == CreateClass.EXISTS_ERROR) {
			var title = "Confirm Overwrite";
			var msg = "Are you sure you want to overwrite the existing file at:\n" + parent.path + "?";
			var ps = Components.classes["@mozilla.org/embedcomp/prompt-service;1"].getService(Components.interfaces.nsIPromptService);
			var rv = ps.confirmEx(window, title, msg, ps.BUTTON_TITLE_IS_STRING * ps.BUTTON_POS_0 + ps.BUTTON_TITLE_IS_STRING * ps.BUTTON_POS_1, "Yes", "No", null, null, {});

			if(rv == 0) {
				try {
					var file = new AsFile();
					var oldFile = file.open(parent.path);
					oldFile.remove(false);
					parent.create(CreateClass.NORMAL_FILE_TYPE, CreateClass.LINUX_PERMISSIONS);
					this.writeContents(parent);
				} catch(e) {
					alert("File Failed to create because:\n" + e.toString());
				}
			}
		}

	}

}

WrittenFile.prototype.writeContents = function(file) {
	try {
		var foStream = Components.classes["@mozilla.org/network/file-output-stream;1"].createInstance(Components.interfaces.nsIFileOutputStream);

		// use 0x02 | 0x10 to open file for appending.
		foStream.init(file, 0x02 | 0x08 | 0x20, 0664, 0); // write, create, truncate
		foStream.write(this.fileString, this.fileString.length);
		foStream.close();
		this.onWriteCompleted(file.path);
	} catch(e) {
		alert("There was an issue writing the data to disk at: " + file.path + "\n" + e.toString());
	}
}

WrittenFile.prototype.onWriteCompleted = function(path) {
	this.success = true;
	this.path = path;
//		alert("File Created Successfully at:\n" + path);
}
