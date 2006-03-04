
var GenerateTestSuites = function(startDir, tokenFactory) {
	this.tokenFactory = tokenFactory;
	this.ignoreList = this.buildIgnoreList();
	this.regx = new RegExp(this.testCaseExpr);

	var file = new AsFile();
	var dir = file.open(startDir);
	this.parseDir(dir, "", true);
}

GenerateTestSuites.prototype = new Object();
GenerateTestSuites.prototype.tokenFactory;
GenerateTestSuites.prototype.suiteName = CreateClass.TESTSUITE_NAME;
GenerateTestSuites.prototype.testCaseExpr = CreateClass.TESTCASE_EXPRESSION;
GenerateTestSuites.prototype.ignoreList;

GenerateTestSuites.prototype.buildIgnoreList = function() {
	return CreateClass.IGNORE_EXPRESSIONS.split(" ");
}

GenerateTestSuites.prototype.getItemName = function(name, path) {
	var arr = name.split(CreateClass.ACTIONSCRIPT_SUFFIX);
	name = arr[0];

	if(path == "") {
		return name;
	} else {
		return path + "." + name;
	}
}

GenerateTestSuites.prototype.parseDir = function(dir, path, firstDir) {
	var entries = dir.directoryEntries;
	var foundTestCase = false;
	var suite = this.tokenFactory.getTestSuiteDefinition();
	var name;

	if(!firstDir) {
		path += "." + dir.leafName;
	}
	suite.setLocation(dir);
	suite.setName(this.getItemName(this.suiteName, path));

	if(path.substr(0,1) == ".") {
		path = path.substr(1);
	}

	try {
		while(entries.hasMoreElements())
		{
			var entry = entries.getNext();
			entry.QueryInterface(Components.interfaces.nsIFile);
			if(this.ignoreFile(entry)) {
				continue;
			}

			if(entry.isDirectory()) {
				name = entry.leafName + "." + this.suiteName;
				if(this.parseDir(entry, path)) {
					suite.addItem(this.getItemName(name, path));
					foundTestCase = true;
				}
			}

			if(entry.exists() && entry.isFile() && entry.leafName.search(this.regx) > -1) {
				suite.addItem(this.getItemName(entry.leafName, path));
				foundTestCase = true;
			}
		}

		if(foundTestCase) {
			this.writeFile(suite);
		} else {
			this.removeTestSuite(suite);
		}
		return foundTestCase;

	} catch(e) {
		alert(">> exception caught: " + e.toString());
	}

}

GenerateTestSuites.prototype.removeTestSuite = function(suite) {
	var file = suite.location;
	file.append(this.suiteName);
	if(file.exists()) {
		file.remove(false);
	}
}

GenerateTestSuites.prototype.writeFile = function(suite) {
//	alert(">> attempting to write file at: " + suite.toString());
	var file = suite.location;
	file.append(this.suiteName);
	if(file.exists()) {
		file.remove(false);
	}

	file.create(CreateClass.NORMAL_FILE_TYPE, 0);
	this.writeContents(file, suite.toString());
}

GenerateTestSuites.prototype.writeContents = function(file, contents) {
	try {
		var foStream = Components.classes["@mozilla.org/network/file-output-stream;1"].createInstance(Components.interfaces.nsIFileOutputStream);

		// use 0x02 | 0x10 to open file for appending.
		foStream.init(file, 0x02 | 0x08 | 0x20, 0664, 0); // write, create, truncate
		foStream.write(contents, contents.length);
		foStream.close();
//		this.onWriteCompleted(file.path);
	} catch(e) {
		alert("There was an issue writing the data to disk at: " + file.path + "\n" + e.toString());
	}
}

GenerateTestSuites.prototype.ignoreFile = function(ref) {
	var arr = this.ignoreList;
	for(var i in arr) {
		if(ref.leafName.indexOf(arr[i]) > -1) {
			return true;
		}
	}
	return false;
}
