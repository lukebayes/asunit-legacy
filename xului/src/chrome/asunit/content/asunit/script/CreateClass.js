
var CreateClass = function() {
	this.projectModel = new ProjectModel(this);
}

CreateClass.LINUX_PERMISSIONS 			= 0750;
CreateClass.AVAILABLE_TEMPLATES			= ["as2", "as25", "as3"];
CreateClass.TESTSUITE_NAME 				= "AllTests.as";
CreateClass.TESTCASE_EXPRESSION 		= "Test\.as$";
CreateClass.SINGLETON 					= "singleton";
CreateClass.ACTIONSCRIPT_SUFFIX 		= ".as";
CreateClass.DEFAULT_ISSUE 				= "warning";
CreateClass.WARNING 					= "warning";
CreateClass.ERROR 						= "error";
CreateClass.WARNING_IMAGE 				= "chrome://global/skin/icons/Warning.png";
CreateClass.ERROR_IMAGE 				= "chrome://global/skin/icons/Error.png";
CreateClass.WARNING_LABEL 				= "Warning: \n";
CreateClass.ERROR_LABEL 				= "Error: \n";
CreateClass.FILE_SEPARATOR 				= "\\";
CreateClass.FILE_EXPRESSION 			= ".as";
CreateClass.IGNORE_EXPRESSIONS 			= ".svn .cvs AllTests aso";
CreateClass.INTERFACE_CONVENTIONS 		= "^I[A-Z] able$";
CreateClass.SUPERCLASSES_TO_MOVIECLIP 	= "controls";
CreateClass.NORMAL_FILE_TYPE 			= 0;
CreateClass.EXISTS_ERROR 				= "NS_ERROR_FILE_ALREADY_EXISTS";
CreateClass.defaultClassName 			= "com.yourdomain.yourproject.YourClass";
CreateClass.CHANGE_SELECTION 			= true;;

CreateClass.prototype.projectMenuList;
CreateClass.prototype.projectMenuPopup;
CreateClass.prototype.projectModel;
CreateClass.prototype.model;
CreateClass.prototype.testFolder;
CreateClass.prototype.unitTestOutput;
CreateClass.prototype.isSerializable;
CreateClass.prototype.isDisplayObject;
CreateClass.prototype.addPackagesPrefix;
CreateClass.prototype.icExpressions;
CreateClass.prototype.storageBox;
CreateClass.prototype.superClassName;
CreateClass.prototype.debugPanel;
CreateClass.prototype.currentPath;
CreateClass.prototype.classPath;
CreateClass.prototype.sourceFolder;
CreateClass.prototype.className;
CreateClass.prototype.keepOnTop;
CreateClass.prototype.targetEnvironment;
CreateClass.prototype.constructorType;
CreateClass.prototype.issueContainer;
CreateClass.prototype.finder;
CreateClass.prototype.interfacesList;
CreateClass.prototype.finderIsInterface;
CreateClass.prototype.showOnlyInterfaces;
CreateClass.prototype.createTestCase;
CreateClass.prototype.generateTestSuites;
CreateClass.prototype.addPublicStaticMain;
CreateClass.prototype.addDoTrace;
CreateClass.prototype.addStageProperties;
CreateClass.prototype.lastTestFolder;
CreateClass.prototype.testIsSameAsSource;
CreateClass.prototype.standardTestCase;
CreateClass.prototype.mockObjectTestCase;
CreateClass.prototype.asyncTestCase;
CreateClass.prototype.gettingStarted;
CreateClass.prototype.lastInterfaceAdded;
CreateClass.prototype.tokenFactory;

CreateClass.prototype.testButton;
CreateClass.prototype.createButton;
CreateClass.prototype.interfaceAddButton;
CreateClass.prototype.interfaceRemoveButton;
CreateClass.prototype.privateModifier
CreateClass.prototype.singletonModifier

CreateClass.prototype.onload = function() {
	window.setTimeout(this.finishInit, 300, this);
}

CreateClass.prototype.finishInit = function(scope) {
	scope.init();
}

CreateClass.prototype.onUnload = function() {
	this.storageBox.setAttribute("projectModel", this.projectModel.toString());
}

CreateClass.prototype.init = function() {
	try {
		this.buildElementReferences();
		this.initializeModel();
		this.onTestIsSameAsSourceClicked(this.testIsSameAsSource);
	} catch(e) {
		alert(">> init error: " + e.toString());
	}
}

CreateClass.prototype.initializeModel = function() {
	var serialized = this.getSerializedModel();
	this.projectModel.fromString(serialized);
}

CreateClass.prototype.getProjectModel = function() {
	return this.projectModel;
}

CreateClass.prototype.getSerializedModel = function() {
	return this.storageBox.getAttribute("projectModel");
}

CreateClass.prototype.buildElementReferences = function() {
	this.projectMenuList		= document.getElementById("projectMenuList");
	this.projectMenuPopup		= document.getElementById("projectMenuPopup");
	this.storageBox 			= document.getElementById("storageBox");
	this.sourceFolder 			= document.getElementById("sourceFolder");
	this.testFolder 			= document.getElementById("testFolder");
	this.testIsSameAsSource 	= document.getElementById("testIsSameAsSource");

	this.isSerializable 		= document.getElementById("isSerializable");
	this.isDisplayObject		= document.getElementById("isDisplayObject");
	this.addPackagesPrefix 		= document.getElementById("addPackagesPrefix");
	this.addPublicStaticMain 	= document.getElementById("addPublicStaticMain");
	this.addDoTrace 			= document.getElementById("addDoTrace");
	this.addStageProperties 	= document.getElementById("addStageProperties");

	this.createTestCase 		= document.getElementById("createTestCase");
	this.generateTestSuites 	= document.getElementById("generateTestSuites");
	this.showOnlyInterfaces 	= document.getElementById("showOnlyInterfaces");
	this.interfacesList 		= document.getElementById("interfacesList");
	this.classPath 				= document.getElementById("classPath");
	this.superClassName 		= document.getElementById("superClassName");
	this.className 				= document.getElementById("className");
	this.keepOnTop 				= document.getElementById("keepOnTop");
	this.constructorType 		= document.getElementById("constructorType");
	this.targetEnvironment 		= document.getElementById("targetEnvironment");

	this.standardTestCase		= document.getElementById("standardTestCase");
	this.mockObjectTestCase 	= document.getElementById("mockObjectTestCase");
	this.asyncTestCase 			= document.getElementById("asyncTestCase");

	this.interfaceAddButton 	= document.getElementById("interfaceAdd");
	this.interfaceRemoveButton 	= document.getElementById("interfaceRemove");
	this.testButton 			= document.getElementById("testButton");
	this.createButton 			= document.getElementById("createButton");
	this.privateModifier 		= document.getElementById("cModifiers-private");
	this.singletonModifier 		= document.getElementById("cModifiers-singleton");
}

CreateClass.prototype.onProjectModelChanged = function(event) {
	this.rebuildProjectList(true);
}


CreateClass.prototype.onCurrentProjectChanged = function(event) {
	this.setModel(event.data);
}

CreateClass.prototype.setModel = function(newModel) {
	if(this.model != undefined) {
		this.model.removeListener(this);
	}

	this.model = newModel;
	model = newModel;
	this.model.addListener(this);
	var str = this.model.toString();
	this.model.fromString(str);
}

CreateClass.prototype.getModel = function() {
	return this.model;
}

CreateClass.prototype.rebuildProjectList = function(changeSelection) {
//	var projects = this.projectModel.getProjects();
//	alert("pmenu popup: " + this.projectMenuPopup + " projects ln: " + projects.length);

	try {
		var projects = this.projectModel.getProjects();
		var currentProject = this.projectModel.getCurrentProject();
		var list = this.projectMenuList;
		var found = false;
		list.removeAllItems();

		count = projects.length;
		for(var i = 0; i < count; i++) {
			list.appendItem(projects[i].projectName, projects[i].projectId);
			if(changeSelection && projects[i] == currentProject) {
				list.selectedIndex = i;
				found = true;
			}
		}

		if(changeSelection && !found) {
			list.selectedIndex = 0;
		}
	}
	catch(e) {
		alert(">>Error: " + e.toString());
	}
}

CreateClass.prototype.onSourceFolderChanged = function(event) {
	var value = event.source.getSourceFolder();
	if(this.sourceFolder.value != value) {
		this.sourceFolder.value = value;
		this.model.clearClassCache();
	}
	if(this.testIsSameAsSource.checked) {
		this.model.setTestFolder(this.sourceFolder.value);
	}
}

CreateClass.prototype.onTestFolderChanged = function(event) {

	this.testFolder.value = event.source.getTestFolder();
	if(this.model.getSourceFolder() == this.model.getTestFolder()) {
		this.testIsSameAsSource.checked = true;
	}
	this.onTestIsSameAsSourceClicked(this.testIsSameAsSource);

//	this.testIsSameAsSource.checked = (this.testFolder.value == this.sourceFolder.value);
//	this.onTestIsSameAsSourceClicked(this.testIsSameAsSource);

}

CreateClass.prototype.doOnClassPathChanged = function(str) {
	if(!this.hasFocus(this.classPath)) {
		this.model.setClassPath(this.classPath.value);
	}
}

CreateClass.prototype.onClassPathChanged = function(event) {
	var value = event.source.getClassPath();
	if(this.classPath.value != value) {
		this.classPath.value = value;
		this.model.clearClassCache();
	}
}

CreateClass.prototype.onClassNameChanged = function(event) {
	var value = event.source.getClassName();
	if(this.className.value != value) {
		this.className.value = value;
	}
}

CreateClass.prototype.onSuperClassNameChanged = function(event) {
	this.superClassName.value = event.source.getSuperClassName();
}

CreateClass.prototype.onIsDisplayObjectChanged = function(event) {
	this.isDisplayObject.checked = event.data;
}

CreateClass.prototype.onTemplateChanged = function(event) {
	var value = event.data;
	this.tokenFactory = TokenFactory.create(value);

	this.model.clearClassCache();
	var isAs3 = (value == "as3");
	this.singletonModifier.disabled = isAs3;
	this.privateModifier.disabled = isAs3;
	this.isSerializable.disabled = isAs3;
	this.isDisplayObject.disabled = !isAs3;

	if(isAs3) {
		this.model.setIsSerializable(false);
		this.constructorType.selectedIndex = 0;
	}

	this.setSelectedTemplate(value);
}

CreateClass.prototype.setSelectedTemplate = function(value) {
	var str = "";
	var templates = CreateClass.AVAILABLE_TEMPLATES;
	var ln = templates.length;
	var combo = this.targetEnvironment;
	for(var i = 0; i < ln; i++) {
		if(templates[i] == value) {
//			alert("found template AT: " + i);
			combo.selectedIndex = i;
			return;
		}
	}
}

CreateClass.prototype.onConstructorTypeChanged = function(event) {
	var combo = this.targetEnvironment;

	alert("on template changed with: " + combo);
}

CreateClass.prototype.onConstructorTypeChanged = function(event) {
	var value = event.source.getConstructorType();
	if(this.constructorType.selectedIndex != value) {
		this.constructorType.selectedIndex = value;
	}
}

CreateClass.prototype.onInterfacesChanged = function(event) {
	var interfaces = event.source.getInterfaces();
	var list = this.interfacesList;
	var count = list.getRowCount();
	for(var i = 0; i < count; i++) {
		list.removeItemAt(0);
	}
	count = interfaces.length;
	var item;

	for(var i = 0; i < count; i++) {
		if(interfaces[i] != "") {
			item = document.createElement("listitem");
			item.setAttribute("label", interfaces[i]);
			list.appendChild(item);
		}
	}
}

CreateClass.prototype.onInterfaceAdded = function(event) {
	var interface = event.data;
	var list = this.interfacesList;
	var count = list.getRowCount();
	var child;
	for(var i = 0; i < count; i ++) {
		child = list.getItemAtIndex(i);
		if(child.label == interface) {
			list.selectedItem = child;
			return;
		}
	}
}

CreateClass.prototype.onShowOnlyInterfacesChanged = function(event) {
	this.showOnlyInterfaces.checked = event.source.getShowOnlyInterfaces();
}

CreateClass.prototype.onCreateTestCaseChanged = function(event) {
	this.createTestCase.checked = event.source.getCreateTestCase();

	this.standardTestCase.disabled   = !this.createTestCase.checked;
	this.mockObjectTestCase.disabled = !this.createTestCase.checked;
	this.asyncTestCase.disabled      = !this.createTestCase.checked;
}

CreateClass.prototype.onGenerateTestSuitesChanged = function(event) {
	this.generateTestSuites.checked = event.source.getGenerateTestSuites();
}

CreateClass.prototype.onIsSerializableChanged = function(event) {
	var value = event.source.getIsSerializable();
	this.isSerializable.checked = value;
	this.addPackagesPrefix.disabled = !value;
}

CreateClass.prototype.onAddPackagesPrefixChanged = function(event) {
	this.addPackagesPrefix.checked = event.source.getAddPackagesPrefix();
}

CreateClass.prototype.showAsUnitUi = function() {
	this.unitTestOutput = window.open("UnitTestOutput.xul", "asunitui", "chrome,dependent,resizable");
}

CreateClass.prototype.showGettingStarted = function() {
	this.getttingStarted = window.open("SetupWizard.xul", "gettingStarted", "modal,chrome,dependent,resizable");
}

CreateClass.prototype.onBrowseForSuperClass = function() {
	this.doFinderSubmit = function(str) {
		this.model.setSuperClassName(str);
	}
	this.finderIsInterface = false;
	this.finder = window.open("Finder.xul",
				  "finderWindow",
				  "chrome,dependent,modal,resizable");
}

CreateClass.prototype.onBrowseForInterface = function() {
	this.doFinderSubmit = function(str) {
		this.lastInterfaceAdded = str;
		this.model.addInterface(str);
	}

	this.finderIsInterface = this.showOnlyInterfaces.checked;
	this.finder = window.open("Finder.xul",
				  "finderWindow",
				  "chrome,dependent,modal,resizable");
}

CreateClass.prototype.onEditPath = function() {
	this.currentPath = this.model.getClassPath();
	this.pathEditor = window.open("EditPath.xul",
				      "pathEditorWindow",
				      "chrome,dependent,resizable");
}

CreateClass.prototype.onFinderInput = function(str) {
	this.doFinderSubmit(str);
}

CreateClass.prototype.onTestIsSameAsSourceClicked = function(checkBox) {
//	if(this.testIsSameAsSource.checked != checkBox.checked) {
//		this.testIsSameAsSource.checked = checkBox.checked;
//	}

	var isChecked = checkBox.checked;
	this.testButton.disabled = isChecked;
	this.testFolder.disabled = isChecked;

	if(isChecked) {
		this.lastTestFolder = this.testFolder.value;
		this.testFolder.value = this.sourceFolder.value;
	} else if(this.lastTestFolder != null) {
		this.testFolder.value = this.lastTestFolder;
		this.lastTestFolder = null;
	}
}

CreateClass.prototype.activatePackagesAndSerializable = function() {
	this.isSerializable.checked = true;
	this.addPackagesPrefix.checked = true;
	this.addPackagesPrefix.disabled = false;
}

//CreateClass.prototype.onIssueEncountered = function(type, msg) {
//	var type = (type == null) ? CreateClass.DEFAULT_ISSUE : type;
//	this.issueContainer.appendChild(this.issueImage);
//	this.issueContainer.appendChild(this.issueMessage);
//
//	if(type == CreateClass.WARNING) {
//		this.issueImage.src = CreateClass.WARNING_IMAGE;
//		this.issueMessage.value = CreateClass.WARNING_LABEL + msg;
//	} else if(type == CreateClass.ERROR ) {
//
//	}
//}

/*
CreateClass.prototype.onTemplateSelected = function(menu) {
	this.storageBox.setAttribute("lastTargetEnvironment", menu.selectedIndex);
	var sel = menu.selectedItem.value;
	if(sel != "as2") {
		this.addPublicStaticMain.checked = false;
		this.onAddPublicMainChanged(this.addPublicStaticMain);
	}
}
*/

CreateClass.prototype.onAddPublicMainChanged = function(checkBox) {
	this.addDoTrace.disabled = !checkBox.checked;
	this.addStageProperties.disabled = !checkBox.checked;
}

CreateClass.prototype.onBrowseForSourceFolder = function() {
	var result = this.chooseDirectory(this.sourceFolder.value);
	this.model.setSourceFolder(result);
}

CreateClass.prototype.onBrowseForTest = function() {
	var result = this.chooseDirectory(this.testFolder.value);
	this.model.setTestFolder(result);
}

CreateClass.prototype.chooseDirectory = function(startDir) {
	var nsIFilePicker = Components.interfaces.nsIFilePicker;
	var fp = Components.classes["@mozilla.org/filepicker;1"].createInstance(nsIFilePicker);
	fp.init(window, "Select Directory", nsIFilePicker.modeGetFolder);
	var res = fp.show();

	if (res == nsIFilePicker.returnOK){
		return fp.file.path;
	}

	return startDir;
}

CreateClass.prototype.hasFocus = function(element) {
	try {
		var focused = document.commandDispatcher.focusedElement;
		while(focused.getAttribute != null) {
			if(focused == element) {
				return true;
			}
			focused = focused.parentNode;
		}
		return false;
	} catch(e) {
		alert("exception: " + e.toString());
		return false;
	}
}

CreateClass.prototype.onRemoveInterface = function() {
	var index = this.interfacesList.selectedIndex;
	if(index == 0) {
		index = 1;
	}
	this.model.removeInterface(this.interfacesList.selectedItem.label);
	this.interfacesList.selectedIndex = --index;
}

// Called from child windows to determine whether or not a string name
// is an interface (by naming convention only - not real introspection)
CreateClass.prototype.isInterfaceByConvention = function(name) {
	try {
		if(CreateClass.iConventions == null) {
			var arr = CreateClass.INTERFACE_CONVENTIONS.split(" ");
			this.icExpressions = new Array();
			for(var i = 0; i < arr.length; i++) {
				this.icExpressions.push(new RegExp(arr[i]));
			}
		}
		var ln = arr.length;
		var regx;
		for(var i = 0; i < ln; i++) {
			regx = this.icExpressions[i];
			if(name.search(regx) > -1) {
				return true;
			}
		}
	} catch(e) {
		alert("CreateClass.isInterfaceByConvention exception: " + e.toString());
	}
	return false;
}

CreateClass.prototype.getIsSerializable = function() {
	return this.isSerializable.checked;
}

CreateClass.prototype.getAddPackagesPrefix = function() {
	return this.addPackagesPrefix.checked;
}

CreateClass.prototype.doGenerateTestSuites = function(suppressOutput) {
	try {
		var suites = new GenerateTestSuites(this.model.getSourceFolder(), this.tokenFactory);
		if(this.model.getTestFolder() != this.model.getSourceFolder()) {
			var suites = new GenerateTestSuites(model.getTestFolder(), this.tokenFactory);
		}
		if(!suppressOutput) {
			alert("Test Suites Created Successfully");
		}
	} catch(e) {
		alert(e.toString());
	}
}

CreateClass.prototype.onGenerateTestSuites = function(checkBox) {
	if(checkBox.checked) {
		var str = "Warning: This option will automatically traverse every directory forward of your 'Source Folder' and";
		str += " will destroy all files named AllTests.as, then it will create new versions of AllTests.as files only in";
		str += " those directories that contain files that meet the following Regular Expression: " + CreateClass.TESTCASE_EXPRESSION;

		alert(str);

	}
}

CreateClass.prototype.executeCreate = function(onlyTestCase) {

	var model = this.model;
	if(!model.validate()) {
		return;
	}

	// TODO: Prompt the user if their new Class ends in "Test"
	// maybe they *just* want to create a TestCase, and we should
	// accomodate them... need to refactor this method to support this
	// though...
//	try {
//		var regx = new RegExp("Test$");
//		if(model.fullClassName.search(regx) > -1) {
//			alert("only a test case?");
//		}
//	} catch(e) {
//		alert(e.toString());
//	}

	try {
		try {
			var classDef = this.tokenFactory.getClassDefinition(model);
			var myClass = new CreateNewClass(model.getSourceFolder(), model.getClassName(), classDef.toString());
			this.className.select();
		} catch(e) {
			alert("File Creation Failed because of:\n" + e.toString());
		}

		var file = new AsFile();
		var testDir = file.open(model.getTestFolder());
		if(!testDir.exists()) {
			alert("You must set a valid (existing) Test Folder before executing Create. You attempted with: " + model.getTestFolder());
			return;
		}

		var testDef = new Object();
		var testCase = new Object();
		var mockDef = new Object();
		var mockFile = new Object();

		testDef.success = false;
		testCase.success = false;
		mockFile.success = false;

		if(model.getCreateTestCase()) {
//			this.generateTestCase(model);
			try {
				if(model.getTestCaseType() == ClassModel.MOCK_TYPE) {
					mockDef = this.tokenFactory.getMockDefinition(model);
					mockFile = new CreateNewClass(model.getTestFolder(), model.getMockName(), mockDef.toString());
				}
				testDef = this.tokenFactory.getTestCaseDefinition(model);
				testCase = new CreateNewClass(model.getTestFolder(), model.getTestCaseName(), testDef.toString());

			} catch(e) {
				alert("File Creation Failed because of:\n" + e.toString());
			}
		}

		if(!myClass.success && !testCase.success) {
			alert("File(s) Failed to write to disk, please try again...");
			return;
		}

		var str = "File(s) successfully written to: ";

		if(myClass.success) {
			str += myClass.path;
		}

		if(testCase.success) {
			str += " " + testCase.path;
		}

		if(mockFile.success) {
			str += " " + mockFile.path;
		}

		if(this.generateTestSuites.checked == true) {
			this.doGenerateTestSuites(true);
//			var suites = new GenerateTestSuites(model.getSourceFolder());
//			if(model.getTestFolder() != model.getSourceFolder()) {
//				var suites = new GenerateTestSuites(model.getTestFolder());
//			}
		}

		alert(str);
	} catch(e) {
		alert(e.toString());
	}

	// XULRunner would crash every time you closed it - IF you called CreateClass
	// Added the following line and this behavior stopped... Not sure why.
	var finished = true;
//	alert("FINISHED");
}

var cclass = new CreateClass();
var projectModel = cclass.getProjectModel();
var model = cclass.getModel();
