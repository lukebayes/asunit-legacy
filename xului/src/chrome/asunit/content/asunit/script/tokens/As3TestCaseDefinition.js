
var As3TestCaseDefinition = function(initObj) {
	if(initObj != null) {
		this.init(initObj);
	}
}

As3TestCaseDefinition.prototype = new As3ClassDefinition();

As3TestCaseDefinition.SUPER_CLASS 	= "asunit.framework.TestCase";
As3TestCaseDefinition.ASYNC_SUPER_CLASS = "asunit.framework.AsynchronousTestCase";
As3TestCaseDefinition.URL_LOADER = "flash.net.URLLoader";
As3TestCaseDefinition.URL_LOADER = "flash.net.URLLoader";
As3TestCaseDefinition.URL_REQUEST = "flash.net.URLRequest";
As3TestCaseDefinition.EVENTS_PACKAGE = "flash.events.Event";
//As3TestCaseDefinition.XML_CLASS		= "asunit.framework.TestCaseXml";

As3TestCaseDefinition.prototype.config;
As3TestCaseDefinition.prototype.testCaseName;

As3TestCaseDefinition.prototype.init = function(model) {
	this.initializeMembers();
	this.setFullName(model.getTestCaseName());
	this.config = new As3TestCaseConfig();

	var name = model.getClassName();
	if(model.getTestCaseType() == ClassModel.MOCK_TYPE) {
		name = model.getMockName()
	}

	this.header.removeAllImports();

	if(model.getTestCaseType() == ClassModel.ASYNC_TYPE) {
		this.header.addImport(As3TestCaseDefinition.URL_LOADER);
		this.header.addImport(As3TestCaseDefinition.URL_REQUEST);
		this.header.addImport(As3TestCaseDefinition.ASYNC_SUPER_CLASS);
		this.header.addImport(As3TestCaseDefinition.EVENTS_PACKAGE);
		this.setSuperClass(As3TestCaseDefinition.ASYNC_SUPER_CLASS);
		this.config.setIsAsynchronous(true);
	} else {
		this.setSuperClass(As3TestCaseDefinition.SUPER_CLASS);
	}

	this.config.setRealClassName(name);
	this.config.setClassName(model.getTestCaseName());
	this.config.setIsFactory((model.getConstructorType() == ClassModel.SINGLETON_CONSTRUCTOR));
	this.config.setIsVisual(model.getIsDisplayObject());
}

As3TestCaseDefinition.prototype.toString = function() {
	try {
		var str = "";
		str += this.header.toString();
		str += this.declaration.toString();
		str += this.config.toString();
		str += this.body.toString();
		return str;
	} catch(e) {
		alert(e.toString());
	}
}

