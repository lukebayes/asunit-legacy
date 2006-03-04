
var TestCaseDefinition = function(initObj) {
	this.init(initObj);
}

TestCaseDefinition.prototype 	= new ClassDefinition();
TestCaseDefinition.SUPER_CLASS 	= "com.asunit.framework.TestCase";
TestCaseDefinition.XML_CLASS	= "com.asunit.framework.TestCaseXml";

TestCaseDefinition.prototype.config;
TestCaseDefinition.prototype.testCaseName;

TestCaseDefinition.prototype.init = function(model) {
	this.initializeMembers();

	this.setFullName(model.getTestCaseName());

	this.config = new TestCaseConfig();
	var name = model.getClassName();
	if(model.getTestCaseType() == ClassModel.MOCK_TYPE) {
		name = model.getMockName()
	}

	if(model.getTestCaseType() == ClassModel.ASYNC_TYPE) {
		this.header.addImport(TestCaseDefinition.XML_CLASS);
		this.config.setIsAsynchronous(true);
	}
	this.header.addImport(name);
	this.config.setRealClassName(name);
	this.config.setClassName(model.getTestCaseName());
	this.config.setIsFactory((model.getConstructorType() == ClassModel.SINGLETON_CONSTRUCTOR));
	this.config.setIsVisual((model.getAddPackagesPrefix() && model.getIsSerializable()));

	this.setSuperClass(TestCaseDefinition.SUPER_CLASS);
}

TestCaseDefinition.prototype.toString = function() {
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
