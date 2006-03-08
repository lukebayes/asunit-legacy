
var ClassModel = function() {
	this.init();
}

ClassModel.ENTITY_PATH_as2		= "chrome://asunit/content/data/as2classes.txt";
ClassModel.ENTITY_PATH_as25		= "chrome://asunit/content/data/as25classes.txt";
ClassModel.ENTITY_PATH_as3		= "chrome://asunit/content/data/as3classes.txt";

ClassModel.CHANGED_EVENT 		= "onChanged";
ClassModel.PUBLIC_CONSTRUCTOR 		= 0;
ClassModel.PRIVATE_CONSTRUCTOR 		= 1;
ClassModel.SINGLETON_CONSTRUCTOR 	= 2;
ClassModel.incr					= 1;

ClassModel.PUBLIC_LABEL 		= "public";
ClassModel.PRIVATE_LABEL 		= "private";
ClassModel.SINGLETON_LABEL 		= "singleton";

ClassModel.STANDARD_TYPE		= "standardTestCase";
ClassModel.MOCK_TYPE			= "mockObjectTestCase";
ClassModel.ASYNC_TYPE			= "asyncTestCase";
ClassModel.MOCK_SUFFIX			= "Mock";
ClassModel.TESTCASE_SUFFIX		= "Test";
ClassModel.properties 			=  ["projectName",
									"sourceFolder",
									"testFolder",
									"template",
									"classPath",
									"className",
									"constructorType",
									"superClassName",
									"testCaseType",
									"interfaces",
									"createTestCase",
									"generateTestSuites",
									"addPackagesPrefix",
									"showOnlyInterfaces",
									"showAsUnitUi",
									"isSerializable",
									"isDisplayObject"];

ClassModel.getConstructorLabel = function(code) {
	var arr = new Array();
	arr.push(ClassModel.PUBLIC_LABEL);
	arr.push(ClassModel.PRIVATE_LABEL);
	arr.push(ClassModel.SINGLETON_LABEL);
	return arr[code];
}

ClassModel.incrementer = function() {
	return ClassModel.incr++;
}

ClassModel.prototype = new EventSource();

ClassModel.prototype.projectId;
ClassModel.prototype.projectName	 = "Default Project";
ClassModel.prototype.sourceFolder 	 = "";
ClassModel.prototype.testFolder 	 = "";
ClassModel.prototype.template		 = "";
ClassModel.prototype.classPath		 = "";
ClassModel.prototype.className		 = "";
ClassModel.prototype.constructorType	= ClassModel.PUBLIC_CONSTRUCTOR;
ClassModel.prototype.superClassName	 = "";
ClassModel.prototype.testCaseType	 = ClassModel.STANDARD_TYPE;
ClassModel.prototype.interfaces		 = new Array();

ClassModel.prototype.createTestCase	 = false;
ClassModel.prototype.generateTestSuites = false;
ClassModel.prototype.addPackagesPrefix	= false;
ClassModel.prototype.showOnlyInterfaces	= true;
ClassModel.prototype.showAsUnitUi	 = false;
ClassModel.prototype.isSerializable	 = false;
ClassModel.prototype.isDisplayObject = false;

ClassModel.prototype.entityTable;
ClassModel.prototype.entityBuilder;

ClassModel.prototype.init = function() {
	this.setProjectId(new Date().getTime());
	this.setProjectName(projectModel.getUniqueProjectName(this.projectName));
}

ClassModel.prototype.setProjectId = function(id) {
	this.projectId = id;
}

ClassModel.prototype.setProjectName = function(name) {
	this.projectName = name;
	this.doOnSpecificChange("onProjectModelChanged", name);
}

ClassModel.prototype.getProjectName = function() {
	return this.projectName;
}

ClassModel.prototype.doOnChanged = function(name) {
	var event = new Event();
	event.name = ClassModel.CHANGED_EVENT;
	event.source = this;
	event.data = name;
	this.broadcastEvent(event);
}

ClassModel.prototype.doOnSpecificChange = function(eventName, data) {
	var event = new Event();
	event.name = eventName;
	event.source = this;
	event.data = data;
	this.broadcastEvent(event);
}

ClassModel.prototype.removeInterface = function(interface) {
	var list = this.interfaces;
	var ln = list.length;
	for(var i = 0; i < ln; i++) {
		if(list[i] == interface) {
			list.splice(i, 1);
			break;
		}
	}

	this.doOnChanged("interfaces");
	this.doOnSpecificChange("onInterfacesChanged", this.interfaces);
}

ClassModel.prototype.addInterface = function(interface) {
	var list = this.interfaces;
	var ln = list.length;
	for(var i = 0; i < ln; i++) {
		if(list[i] == interface) {
			this.doOnSpecificChange("onInterfaceAdded", interface);
			return;
		}
	}

	this.interfaces.push(interface);
	this.doOnChanged("interfaces");
	this.doOnSpecificChange("onInterfacesChanged", this.interfaces);
	this.doOnSpecificChange("onInterfaceAdded", interface);
}

ClassModel.prototype.setInterfaces = function(interfaces) {
	this.interfaces = interfaces.split(",");
	this.doOnChanged("interfaces");
	this.doOnSpecificChange("onInterfacesChanged", this.interfaces);
}

ClassModel.prototype.getInterfaces = function() {
	return this.interfaces;
}

ClassModel.prototype.setClassPath = function(classPath) {
	classPath = this.cleanClassPath(classPath);

	this.classPath = classPath;
	this.doOnChanged("classPath");
	this.doOnSpecificChange("onClassPathChanged", this.classPath);

	return this.classPath;
}

ClassModel.prototype.cleanClassPath = function(str) {
	return str;

//	if(str == "" || str == ";" || str == undefined || str == null) {
//		return "";
//	}
//	var arr = str.split(";");
//	for(var i = 0; i < arr.length; i++) {
//		// Remove empty elements
//		if(arr[i] == "") {
//			arr.splice(i, 1);
//			i--;
//		}
//		// Remove duplicate elements
//		for(var k = 0; k < arr.length; k++) {
//			if(k == i) {
//				continue;
//			}
//			if(arr[i] == arr[k]) {
//				alert("Removed duplicate path entry at " + arr[k] + ".");
//				arr.splice(k, 1);
//				k--;
//				i--;
//			}
//		}
//		// Remove invalid elements
//		if(!this.isValidPath(arr[i])) {
//			arr.splice(i, 1);
//			i--;
//		}
//	}
//	return arr.join(";");
}

ClassModel.prototype.getClassPath = function() {
	return this.classPath;
}

ClassModel.prototype.setSourceFolder = function(sourceFolder) {
	if(this.isValidPath(sourceFolder)) {
		this.sourceFolder = sourceFolder;
		this.doOnChanged("sourceFolder");
	}
	this.doOnSpecificChange("onSourceFolderChanged", this.sourceFolder);
	return this.sourceFolder;
}

ClassModel.prototype.getSourceFolder = function() {
	return this.sourceFolder;
}

ClassModel.prototype.setTestFolder = function(testFolder) {
	this.testFolder = testFolder;
	this.doOnChanged("testFolder");
	this.doOnSpecificChange("onTestFolderChanged", this.testFolder);
	return this.testFolder;
}

ClassModel.prototype.getTestFolder = function() {
	return this.testFolder;
}

ClassModel.prototype.setTemplate = function(template) {
	this.template = template;
	this.doOnChanged("template");
	this.doOnSpecificChange("onTemplateChanged", this.template);
	return this.template;
}

ClassModel.prototype.getTemplate = function() {
	return this.template;
}

ClassModel.prototype.setClassName = function(className) {
	this.className = className;
	this.doOnChanged("className");
	this.doOnSpecificChange("onClassNameChanged", this.className);
	return this.className;
}

ClassModel.prototype.getClassName = function() {
	return this.className;
}

ClassModel.prototype.getTestCaseName = function() {
	return this.getClassName() + ClassModel.TESTCASE_SUFFIX;
}

ClassModel.prototype.getMockName = function() {
	return this.getClassName() + ClassModel.MOCK_SUFFIX;
}

ClassModel.prototype.setConstructorType = function(constructorType) {
	this.constructorType = constructorType;
	this.doOnChanged("constructorType");
	this.doOnSpecificChange("onConstructorTypeChanged", this.constructorType);
	return this.constructorType;
}

ClassModel.prototype.getConstructorType = function() {
	return this.constructorType;
}

ClassModel.prototype.setSuperClassName = function(superClassName, supressEvent) {
	this.superClassName = superClassName;
	this.doOnChanged("superClassName");
	this.doOnSpecificChange("onSuperClassNameChanged", this.superClassName);
	return this.superClassName;
}

ClassModel.prototype.getSuperClassName = function() {
	return this.superClassName;
}

ClassModel.prototype.setCreateTestCase = function(createTestCase) {
	this.createTestCase = createTestCase;
	this.doOnChanged("createTestCase");
	this.doOnSpecificChange("onCreateTestCaseChanged", this.createTestCase);
	return this.createTestCase;
}

ClassModel.prototype.setTestCaseType = function(type) {
	this.testCaseType = type;
}

ClassModel.prototype.getCreateTestCase = function() {
	return this.createTestCase;
}

ClassModel.prototype.getTestCaseType = function() {
	return this.testCaseType;
}

ClassModel.prototype.setGenerateTestSuites = function(generateTestSuites) {
	this.generateTestSuites = generateTestSuites;
	this.doOnChanged("generateTestSuites");
	this.doOnSpecificChange("onGenerateTestSuitesChanged", this.generateTestSuites);
	return this.generateTestSuites;
}

ClassModel.prototype.getGenerateTestSuites = function() {
	return this.generateTestSuites;
}

ClassModel.prototype.setAddPackagesPrefix = function(addPackagesPrefix) {
	this.addPackagesPrefix = addPackagesPrefix;
	this.doOnChanged("addPackagesPrefix");
	this.doOnSpecificChange("onAddPackagesPrefixChanged", this.addPackagesPrefix);
	return this.addPackagesPrefix;
}

ClassModel.prototype.getAddPackagesPrefix = function() {
	return this.addPackagesPrefix;
}

ClassModel.prototype.setShowOnlyInterfaces = function(showOnlyInterfaces) {
	this.showOnlyInterfaces = showOnlyInterfaces;
	this.doOnChanged("showOnlyInterfaces");
	this.doOnSpecificChange("onShowOnlyInterfacesChanged", this.showOnlyInterfaces);
	return this.showOnlyInterfaces;
}

ClassModel.prototype.getShowOnlyInterfaces = function() {
	return this.showOnlyInterfaces;
}

ClassModel.prototype.setIsDisplayObject = function(isDisplayObject) {
	this.isDisplayObject = isDisplayObject;
	this.doOnChanged("isDisplayObject");
	this.doOnSpecificChange("onIsDisplayObjectChanged", this.isDisplayObject);
	return this.isDisplayObject;
}

ClassModel.prototype.getIsDisplayObject = function() {
	return this.isDisplayObject;
}

ClassModel.prototype.setIsSerializable = function(isSerializable) {
	this.isSerializable = isSerializable;
	this.doOnChanged("isSerializable");
	this.doOnSpecificChange("onIsSerializableChanged", this.isSerializable);
	return this.isSerializable;
}

ClassModel.prototype.getIsSerializable = function() {
	return this.isSerializable;
}

ClassModel.prototype.setShowAsUnitUi = function(showAsUnitUi) {
	this.showAsUnitUi = showAsUnitUi;
	this.doOnChanged("showAsUnitUi");
	this.doOnSpecificChange("onShowAsUnitUiChanged", this.showAsUnitUi);
	return this.showAsUnitUi;
}

ClassModel.prototype.getShowAsUnitUi = function() {
	return this.showAsUnitUi;
}

ClassModel.prototype.isValidPath = function(path) {

	if(path == "" || path == undefined) {
		return false;
	}

	var asFile = new AsFile();
	try {
		var nsiFile = asFile.open(path);
		var fileExists = nsiFile.exists();
		if(!fileExists) {
			alert("Could not find file at: " + path + ".\n Please try again.");
		}
		return fileExists;
	} catch(e) {
		alert("Could not find file at: " + path + ".\n Please try again.");
		return false;
	}
}

ClassModel.prototype.validate = function() {
	var isValid = true;

	if(this.className == "" || this.className == undefined) {
		alert("You must set a class name before attempting to create.");
		isValid = false;
	}

	if(this.sourceFolder == "") {
		alert("You must set the Source Folder parameter before executing Create. You attempted with: " + this.sourceFolder);
		isValid = false;
	}

	if(this.testFolder == "") {
		alert("You must set the Test Folder parameter before executing Create. You attempted with: " + this.testFolder);
		isValid = false;
	}

	if(this.constructorType == ClassModel.SINGLETON_CONSTRUCTOR &&
	   this.testCaseType == ClassModel.MOCK_TYPE) {
		   alert("Due to technical limitations, you cannot choose 'private w/Singleton' AND 'Mock Object' at the same time");
		   isValid = false;
	}

	var file = new AsFile();
	var dir = file.open(this.sourceFolder);
	if(!dir.exists()) {
		alert("You must set a valid (existing) Source Folder before executing Create. You attempted with: " + this.sourceFolder);
		isValid = false;
	}

	return isValid;
}

ClassModel.prototype.getEntityChromeUrl = function() {
	return ClassModel.ENTITY_PATH_as3;
}

ClassModel.prototype.buildEntityTable = function() {
	this.entityBuilder = new EntityTableBuilder(this);

	this.entityBuilder.addPath(this.getSourceFolder());
	var arr = this.getClassPath().split(";");
	for(var i = 0; i < arr.length; i++) {
		this.entityBuilder.addPath(arr[i]);
	}

	var entityTable = this.entityBuilder.getTable();
//	var output = document.getElementById("output");
//	output.value = table.toString();
	return entityTable;
}

ClassModel.prototype.getEntityTable = function() {
	try {
		if(this.entityTable == null) {
			this.entityTable = this.buildEntityTable();
		}

		// This isn't working right now...
		//this.entityTable.setIsInterface(this.finderIsInterface);

		return this.entityTable;
	} catch(e) {
		alert("ClassModel.getEntityTable:Error " + e.toString());
	}
}

ClassModel.prototype.clearClassCache = function() {
	delete this.entityTable;
}

// Serialization Routines:
ClassModel.prototype.fromString = function(str) {
	var values = str.split("&");
	var ln = values.length;
	var setters = this.buildSetterList();

	for(var i = 0; i < ln; i++) {
		this.parseValuePair(values[i], setters);
	}
}

ClassModel.prototype.buildSetterList = function() {
	var obj = new Object();
	for(var i in this) {
		if(typeof this[i] == "function" && i.indexOf("set") == 0) {
			obj[i] = this[i];
		}
	}
	return obj;
}

ClassModel.prototype.parseValuePair = function(str, setters) {
	try {
		var nameValue = str.split("=");
		var name = nameValue[0];
		var value = nameValue[1];

		for(var i in setters) {
			// Found property name after "set[A-Z]" expression...
			if(i.indexOf(name.substr(1)) == 4) {
				value = this.resolvePrimitive(value);
				try {
					this[i](value);
				}
				catch(e) {
//					alert("failed at: " + i + " : " + value + " with: " + e.toString());
				}
				delete setters[i];
			}
		}
	} catch(e) {
		alert("ClassModel.parseValuePair:Error " + e.toString());
	}
}

ClassModel.prototype.resolvePrimitive = function(value) {
	if(value == "false") {
		return Boolean(false);
	} else if(value == "true") {
		return Boolean(true);
	}
	return value;
}

ClassModel.prototype.toString = function() {
	var prop = "";
	var str = "projectId=" + this.projectId;
	var ln = ClassModel.properties.length;
	for(var i = 0; i < ln; i++) {
		prop = ClassModel.properties[i];
		str += "&" + prop + "=" + this[prop];
	}
	return str;


//	var count = 0;
//	for(var i in this) {
//		if(typeof(this[i]) != "function") {
////		if(i != "listeners" && (typeof this[i]) != "function") {
//			if(count > 0) {
//				str += "&";
//			}
//			str += (i + "=" + this[i]);
//			count++;
//		}
//	}
//	alert("Class Model toString succeeded with: " + str);
//	return str;
}
