
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

LibrarySymbol = function() { 
	trace = fl.trace;
	this.lib = document.library;
}

LibrarySymbol.prototype.addItem = function(type, classPath) {
	this.libPath = this.getLibraryPath(classPath);
	var hasItem = this.alreadyHasItem(this.libPath);

	if(hasItem) {
		this.lib.expandFolder(this.getFolderPath(this.libPath));
		this.lib.selectItem(this.libPath);
		return trace(">> Item already exists in Library at : " + classPath);
	} else {
		var itemCreated = this.lib.addNewItem(type, this.libPath);
		this.expandFolderPath(classPath);
		this.lib.selectItem(this.libPath);
	}

	this.lib.setItemProperty("linkageExportForAS", true);
	this.lib.setItemProperty("linkageIdentifier", classPath);
	this.lib.setItemProperty("linkageClassName", classPath);
	this.lib.setItemProperty("linkageExportInFirstFrame", true);
}

LibrarySymbol.prototype.expandFolderPath = function(path) {
	var p = path.split(".");
	p.pop();
	this.lib.expandFolder(true, true, p[0]);
	var str = p[0];
	for(var i=1; i<p.length; i++) {
		str = str + ("/" + p[i]);
		this.lib.expandFolder(true, true, str);
	}
}

LibrarySymbol.prototype.getLibraryPath = function(path) {
	var p = path.split(".").join("/");
	return "/" + p;
}

LibrarySymbol.prototype.alreadyHasItem = function(path) {
	return (this.lib.selectItem(path)) ? true : false;
}

//--------------------------------------------------
// CreateClass
//--------------------------------------------------

var CreateClass = function()
{
	trace = fl.trace;
	var str = fl.runScript(fl.configURI + "External\ Libraries/asunit/ConfigureFileSeparator.jsfl", "ConfigureFileSeparator");
	this.init();
}

CreateClass.prototype.init = function()
{
	fl.outputPanel.clear();
	// Ensure we have a good working directory...
	if(document.path == undefined) {
		return trace(">> fla FILE MUST BE SAVED FIRST...");
	}
	
	if(!this.checkVersion()) {
		fl.trace(">> To use this feature, you must update your installation of Flash to Version 7.2 or greater. Go to http://www.macromedia.com/flash to find the updater.\n");
		return;
	}

	var wiz = this.getXmlUi();
	var packagePrefix = "";
	var extendsMovieClip = "";

	if(wiz.dismiss != "accept") {
		return; //trace(">> user cancelled the action");
	}

	var cPath = wiz.classPathInput;
	var autoOpen = (wiz.autoOpenCheckBox == "true") ? true : false;
	var isMovie = (wiz.isMovieCheckBox == "true") ? true : false;
	var addPackagePrefix = (wiz.addPackagesCheckBox == "true") ? true : false;
	var updateSuites = (wiz.updateSuitesCheckBox == "true") ? true : false;
	var flashEditor = (wiz.flashEditorCheckBox == "true") ? true : false;

 	document.addDataToDocument("lastCreatedClassName", "string", cPath);
 	document.addDataToDocument("lastAutoOpen", "string", autoOpen);
 	document.addDataToDocument("lastIsMovie", "string", isMovie);
 	document.addDataToDocument("lastAddPackages", "string", addPackagePrefix);
 	document.addDataToDocument("lastUpdateSuites", "string", updateSuites);
 	document.addDataToDocument("lastFlashEditor", "string", flashEditor);

	// Ensure the class is fully qualified Class Name...
	// Not adding support for poorly designed applications...
	if(addPackagePrefix) {
		packagePrefix = "__Packages.";
		extendsMovieClip = "extends MovieClip ";
	}
	
	if(isMovie) {
		extendsMovieClip = "extends MovieClip ";
	}
	
	if(cPath.indexOf(".") == -1) {
		return trace(">> You Must enter a fully qualified class name using dot-syntax.\nEG: com.yourdomain.YourClassName");
	}

	fl.lastCreatedClass = cPath;

	this.classUri = this.classPathToUri(cPath) + ".as";
	this.testClassUri = this.classPathToUri(this.getTestClassPath(cPath)) + ".as";

	this.classPath = this.uriToPath(this.classUri);
	this.testClassPath = this.uriToPath(this.testClassUri);

	this.classContent = this.getClassTemplate(packagePrefix, extendsMovieClip, this.getClassPackage(cPath), this.getClassName(cPath));
	this.testClassContent = this.getTestClassTemplate(this.getClassPackage(cPath), this.getClassName(cPath), this.getTestClassPackage(cPath), this.getTestClassName(cPath));

 	var firstTry = false;
 	var secondTry = false;


	if(fl.version.indexOf("MAC") == -1) {
		if(!this.classExists(this.classUri)) {
	 		firstTry = this.writeFileToPc(this.classPath, this.getFileName(this.classUri), this.classContent, (autoOpen && !flashEditor));
		}
		if(!this.classExists(this.testClassUri)) {
	 		secondTry = this.writeFileToPc(this.testClassPath, this.getFileName(this.testClassUri), this.testClassContent, (autoOpen && !flashEditor));
	 	}
 	} else {
		if(!this.classExists(this.classUri)) {
	 		firstTry = this.writeFileToMac(this.classPath, this.getFileName(this.classUri), this.classContent, this.classUri);
 		}
		if(!this.classExists(this.testClassUri)) {
	 		secondTry = this.writeFileToMac(this.testClassPath, this.getFileName(this.testClassUri), this.testClassContent, this.testClassUri);
 		}
 		if(autoOpen && !flashEditor) {
 			trace(">> You have selected to auto open files without selecting Flash as your Editor, this is not possible on the Mac. Please contact Macromedia if you would like this feature to work.\n");
 		}
 	}

	if(firstTry) {
	 	trace(">> Successfully created file at : " + this.classUri + "\n");
	} else {
 		trace(">> Could Not Create Class because one already exists at : \n" + this.classUri + "\n");
 	}

	if(secondTry) {
	 	trace(">> Successfully created file at : " + this.testClassUri + "\n");
	} else {
 		trace(">> Could Not Create Test Class because a TestCase already exists at : \n" + this.testClassUri + "\n");
	}

 	if(isMovie) {
 		var lib = new LibrarySymbol();
 		lib.addItem("movie clip", cPath);
 	}

	if(updateSuites) {
		fl.runScript(fl.configURI + "Commands/Build\ Test\ Suites.jsfl", "specifyFolder", this.classUri);
	}

	if(autoOpen && flashEditor) {
		fl.openScript(this.classUri);
	}
}

CreateClass.prototype.checkVersion = function() {
	var vers = fl.version.split(" ");
	vers = vers[1].split(",");
	// If the revision number does not reflect "7.2" ++
	// Throw an error to output...
	if(vers[0] < 7 || vers[0] == 7 && vers[1] < 2) {
		return false;
	}
	return true;
}

CreateClass.prototype.writeFileToPc = function(path, fileName, contents, autoOpen) {
 	return FileIo.write(path, fileName, contents, autoOpen);
}

CreateClass.prototype.writeFileToMac = function(path, fileName, contents, fileUri) {
	var folders = path.split("\\\\");
	var foldersLen = folders.length;
	var folderPath = "file:///" + folders[0];

	for(var i = 1; i < foldersLen; i++) {
		if(folders[i].indexOf(".as") == -1) {
			folderPath += "/" + folders[i];
			if(!FLfile.exists(folderPath)) {
				FLfile.createFolder(folderPath);
			}
		}
		else {
			FLfile.write(folderPath + "/" + folders[i], contents);
		}
	}
	
	return true;
}

CreateClass.prototype.getFileName = function(uri)
{
	var str = uri.split("/");
	return str.pop();
}

CreateClass.prototype.uriToPath = function(uri)
{
	var path = uri.split("file:///").join("").split("/").join("\\\\").split("|").join(":");
	// alert(uri.split("file:///").join(""));
	// var path = "/"+uri.split("file:///").join("");
	return path;
}

CreateClass.prototype.getTestClassPath = function(path)
{
	return this.getTestClassPackage(path) + "." + this.getTestClassName(path);
}

CreateClass.prototype.getTestClassName = function(path)
{
	return this.getClassName(path) + "Test";
}

CreateClass.prototype.getTestClassPackage = function(path)
{
	// Now creates tests in the same directory as classes...
	return this.getClassPackage(path);
//	return "test." + this.getClassPackage(path);
}

CreateClass.prototype.getClassPackage = function(path)
{
	var arr = path.split(".");
	arr.pop();
	return arr.join(".");
}

CreateClass.prototype.getClassName = function(path)
{
	var arr = path.split(".");
	return arr.pop();
}

CreateClass.prototype.getXmlUi = function()
{
	var fUri = fl.configURI + "Commands/Create\ Class.xul";
	return fl.getDocumentDOM().xmlPanel(fUri);
}

CreateClass.prototype.getCurrentUri = function()
{
	var dPath = document.path.split(FLfile.separator);
	dPath.pop();
	dPath = dPath.join("/")

	if(dPath.charAt(1) == ":") {
		dPath = dPath.substring(0,1) + "|" + dPath.substring(2);
	}
	return "file:///" + dPath + "/";
}

CreateClass.prototype.classPathToUri = function(uri)
{
	return this.getCurrentUri() + uri.split(".").join("/");
}

CreateClass.prototype.classExists = function(uri)
{
	return fl.fileExists(uri);
}

CreateClass.prototype.getClassTemplate = function(pkgPrefix, extndsMvclp, pkg, name)
{
	var str = FLfile.read(this.getClassTemplateUri());
	return this.replaceValues(pkgPrefix, extndsMvclp, str, pkg, name);
}

CreateClass.prototype.getTestClassTemplate = function(pkg, name, testPkg, testName)
{
	var str = FLfile.read(this.getTestClassTemplateUri());
	return this.replaceValues("", "", str, pkg, name, testPkg, testName);
}

CreateClass.prototype.replaceValues = function(pkgPrefix, extndsMvclp, str, pkg, name, testPkg, testName)
{
	str = str.split("[%PACKAGES_PREFIX%]").join(pkgPrefix);
	str = str.split("[%EXTENDS%]").join(extndsMvclp);
	str = str.split("[%PACKAGE_NAME%]").join(pkg);
	str = str.split("[%CLASS_NAME%]").join(name);
	str = str.split("[%TEST_PACKAGE_NAME%]").join(testPkg);
	str = str.split("[%TEST_NAME%]").join(testName);
	str = str.split("\r").join("");
	return str;
}

CreateClass.prototype.getClassTemplateUri = function()
{
	return fl.configURI + "External\ Libraries/asunit/ClassTemplate.as";
}

CreateClass.prototype.getTestClassTemplateUri = function()
{
	return fl.configURI + "External\ Libraries/asunit/TestClassTemplate.as";
}

var createClass = new CreateClass();

