
/************************************************

Copyright (C) 2004 Luke Bayes and Ali Mills

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

Any questions related to this code should be directed to :
lukebayes@users.sourceforge.net
or
alimills@users.sourceforge.net

************************************************/

//--------------------------------------------------
// Create Test Suites
//--------------------------------------------------

GenerateTestSuites = function(startUri) {
	var str = fl.runScript(fl.configURI + "External\ Libraries/asunit/ConfigureFileSeparator.jsfl", "ConfigureFileSeparator");
	this.init(startUri);
}

GenerateTestSuites.prototype.init = function(startUri) {
	trace = fl.trace;
// 	fl.outputPanel.clear();
	if(document.path == undefined) {
		trace(">> Cannot search a path until the current document is saved to one.");
	}
	if(startUri == undefined) {
		var uri = this.getCurrentUri();
	} else {
		var uri = startUri;
	}
	trace(">> Searching for TestCases at : " + uri);
	this.searchDirectory(uri, uri.length+1);
	trace(">> Create Test Suites Completed");
}

GenerateTestSuites.prototype.getIgnoredDirs = function(dir) {
	// ADD DIRECTORIES TO IGNORE HERE - IN ALLCAPS...
	// any directories found here, will NOT be walked into...
	if(this.ignoredDirs == undefined) {
		this.ignoredDirs = new Object();
		this.ignoredDirs["CVS"] = true;
		this.ignoredDirs[".CVS"] = true;
		this.ignoredDirs["_CVS"] = true;
		this.ignoredDirs["SVN"] = true;
		this.ignoredDirs[".SVN"] = true;
		this.ignoredDirs["_SVN"] = true;
		this.ignoredDirs[".METADATA"] = true;
		this.ignoredDirs[".SETTINGS"] = true;
	}
	return this.ignoredDirs;
}

GenerateTestSuites.prototype.isIgnoredDir = function(dir) {
	var dirs = this.getIgnoredDirs();
	if(dirs[dir]) {
		return true;
	}
	return false;
}

GenerateTestSuites.prototype.getCurrentUri = function() {
	var dPath = document.path.split(FLfile.separator);
	dPath.pop();
	dPath = dPath.join("/")
	var str = "file:///" + dPath.split(":").join("|") + "/";
	return str;
}

GenerateTestSuites.prototype.toUri = function(cPath, suffix) {
	return this.getCurrentUri() + cPath.split(".").join("/") + suffix;
}

GenerateTestSuites.prototype.searchDirectory = function(uri, baseMask) {
	var str = "";
	var testSuiteStr = "";
	str = uri.substring(baseMask);
	var relativePath = (str.length > 0) ? str + "/" : str; // Give it a slash suffix
	var relPathDots = relativePath.split("/").join(".");
	this.removeExistingAllTestsFiles(uri);
	str = "";
	var dirList = FLfile.listFolder(uri, "directories");
	for(var i=0; i<dirList.length; i++) {
		if(!this.isIgnoredDir(dirList[i].toUpperCase())) {
			this.searchDirectory(uri+"/"+dirList[i], baseMask);
			str += this.getAddStringLine(relPathDots + dirList[i] + ".AllTests");
		}
	}
	str += this.buildTestSuiteAddString(uri, relativePath);
	testSuiteStr = this.getSuiteTemplateString(relPathDots, str);
	var success = FLfile.write(uri+"/AllTests.as", testSuiteStr);
	if(success) {
		trace(">> created TestSuite at : " + relativePath + "AllTests.as");
	}
}

GenerateTestSuites.prototype.getSuiteTemplateString = function(pkg, addTestStr)
{
	var str = FLfile.read(this.getTestSuiteTemplateUri());
	str = this.replaceValues(str, pkg, addTestStr);
	return str;
}

GenerateTestSuites.prototype.replaceValues = function(str, pkg, addTestStr)
{
	str = str.split("[%PACKAGE_NAME%]").join(pkg);
	str = str.split("[%TEST_LIST%]").join(addTestStr);
	str = str.split("import *;").join("");
	return str;
}

GenerateTestSuites.prototype.getTestSuiteTemplateUri = function()
{
	return fl.configURI + "External\ Libraries/asunit/TestSuiteTemplate.as";
}

GenerateTestSuites.prototype.buildTestSuiteAddString = function(uri, relativePath) {
	var str = "";
 	var fileList = FLfile.listFolder(uri, "files");
	var relPathDots = relativePath.split("/").join(".");
	for(var i=0; i<fileList.length; i++) {
		if(fileList[i].indexOf("Test") > -1 && fileList[i].indexOf(".as") > -1 && fileList[i].indexOf("Test") > 0) {
			var className = fileList[i].substring(0, fileList[i].indexOf("."));
			str += this.getAddStringLine(relPathDots + className);
		}
	}
	return str;
}

GenerateTestSuites.prototype.getAddStringLine = function(filePath) {
		return "addTest(new " + filePath + "());\n\t\t";
}

GenerateTestSuites.prototype.removeExistingAllTestsFiles = function(uri) {
 	var fileList = FLfile.listFolder(uri, "files");
 	for(var i=0; i<fileList.length; i++) {
 		if(fileList[i] == "AllTests.as") {
			FLfile.remove(uri + "/" + fileList[i]);
 		}
 	}	
}

function specifyFolder(uri) {
	var cts = new GenerateTestSuites(uri);
}

var cts = new GenerateTestSuites();
