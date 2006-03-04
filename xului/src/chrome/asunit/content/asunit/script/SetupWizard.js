
var SetupWizard = function() {
}

SetupWizard.prototype.model;
SetupWizard.prototype.modelBackup;
SetupWizard.prototype.targetEnvironment;
SetupWizard.prototype.projectNameLabel;
SetupWizard.prototype.sourceFolder;
SetupWizard.prototype.sourceFolderButton;
SetupWizard.prototype.testButton;
SetupWizard.prototype.testFolder;
SetupWizard.prototype.testIsSameAsSource;

SetupWizard.prototype.onLoad = function() {
	this.init();
}

SetupWizard.prototype.init = function() {
	try {
		this.buildElementReferences();
		this.initializeModel();
		this.onTestIsSameAsSourceClicked(this.testIsSameAsSource);
		this.projectNameLabel.value = model.getProjectName();
		this.projectNameLabel.select();
		epath.init();
	} catch(e) {
//		alert(e.toString());
	}

	this.onTestIsSameAsSourceClicked(this.testIsSameAsSource);
}

SetupWizard.prototype.initializeModel = function() {
	this.model = cclass.getModel();
	this.model.addListener(this);
	var str = this.model.toString();
	this.model.fromString(str);
	this.modelBackup = str;
}

SetupWizard.prototype.onUnLoad = function() {
	this.model.removeListener(this);
}

SetupWizard.prototype.onCancel = function() {
	try {
		if(projectModel.creatingProject) {
			return projectModel.removeSelectedProject();
		}
		else {
			this.model.fromString(this.modelBackup);
			return true;
		}
	}
	catch(e) {
		alert(">> CANCEL ERROR: " + e.toString());
	}
}

SetupWizard.prototype.onTemplatePageShown = function() {
	model.setTemplate(this.targetEnvironment.selectedItem.value);
	this.targetEnvironment.focus();
}

SetupWizard.prototype.onTemplatePageAdvanced = function() {
	// set up the class path to the appropriate framework(s)...
	var url = window.location;
	try {
//		alert("uri: " + document.documentURI);
//		this.file = Components.classes["@mozilla.org/file/local;1"].createInstance(Components.interfaces.nsILocalFile);
//		this.file.initWithPath(filePath);
//		return this.file;

	}
	catch(e) {
		alert("creating file failed with: " + e);
	}
}

SetupWizard.prototype.onSourcePageShown = function() {
		this.sourceFolderButton.focus();
}

SetupWizard.prototype.onTestPageShown = function() {
	if(this.model.getSourceFolder() == this.model.getTestFolder()) {
		this.testIsSameAsSource.checked = true;
	}
	this.onTestIsSameAsSourceClicked(this.testIsSameAsSource);
}

SetupWizard.prototype.onPathPageAdvanced = function() {
	var str = epath.toString();
	this.model.setClassPath(str);
}

SetupWizard.prototype.onFinalPageAdvanced = function() {
	cclass.rebuildProjectList();
}

SetupWizard.prototype.buildElementReferences = function() {
	this.targetEnvironment	= document.getElementById("targetEnvironment");
	this.projectNameLabel	= document.getElementById("projectNameLabel");
	this.sourceFolder 		= document.getElementById("sourceFolder");
	this.sourceFolderButton	= document.getElementById("sourceFolderButton");
	this.testIsSameAsSource = document.getElementById("testIsSameAsSource");
	this.testButton		 	= document.getElementById("testButton");
	this.testFolder 		= document.getElementById("testFolder");
}

SetupWizard.prototype.onSourceFolderChanged = function(event) {
	var value = event.source.getSourceFolder();
	this.sourceFolder.value = value;
	this.sourceFolder.setSelectionRange(0, 0);

	focus();
//	var button = getButton("next");
//	button.focus();
}

SetupWizard.prototype.onTestFolderChanged = function(event) {
	this.testFolder.value = event.source.getTestFolder();

	this.testIsSameAsSource.checked = (this.testFolder.value == this.sourceFolder.value);
	this.onTestIsSameAsSourceClicked(this.testIsSameAsSource);
}

SetupWizard.prototype.onTestIsSameAsSourceClicked = function(checkBox) {
	if(this.testIsSameAsSource.checked != checkBox.checked) {
		this.testIsSameAsSource.checked = checkBox.checked;
	}

	var isChecked = checkBox.checked;
	this.testButton.disabled = isChecked;
	this.testFolder.disabled = isChecked;

	if(isChecked) {
		this.lastTestFolder 	= this.testFolder.value;
		this.testFolder.value 	= this.sourceFolder.value;
	} else if(this.lastTestFolder != null) {
		this.testFolder.value 	= this.lastTestFolder;
		this.lastTestFolder 	= null;
	}

	cclass.testIsSameAsSource.checked = checkBox.checked;
	cclass.onTestIsSameAsSourceClicked(cclass.testIsSameAsSource);
}

var projectModel = window.opener.projectModel;
var cclass = window.opener.cclass;

var model = projectModel.getCurrentProject();
var setupWizard = new SetupWizard();