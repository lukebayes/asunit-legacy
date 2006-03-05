
var As25TestCaseDefinition = function(initObj) {
	this.init(initObj);
}

As25TestCaseDefinition.prototype 	= new ClassDefinition();
As25TestCaseDefinition.SUPER_CLASS 	= "asunit.framework.TestCase";
As25TestCaseDefinition.XML_CLASS	= "asunit.framework.TestCaseXml";

As25TestCaseDefinition.prototype.init = function(model) {
	this.initializeMembers();

	this.setFullName(model.getTestCaseName());

	this.config = new As25TestCaseConfig();

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

	this.setSuperClass(As25TestCaseDefinition.SUPER_CLASS);
}


As25TestCaseDefinition.prototype.toString = function() {
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