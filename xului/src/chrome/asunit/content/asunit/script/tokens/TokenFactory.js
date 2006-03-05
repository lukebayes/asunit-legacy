
//--------------------------------------

var TokenFactory = new Object();

TokenFactory.create = function(name) {
	if(name == "as2") {
		return new As2Factory();
	} else if(name == "as25") {
		return new As25Factory();
	} else if(name == "as3") {
		return new As3Factory();
	}
}

//--------------------------------------

var As25Factory = function() {
}

As25Factory.prototype.type = "ActionScript 2.0";

As25Factory.prototype.getClassDefinition = function(model) {
	return new ClassDefinition(model);
}

As25Factory.prototype.getTestCaseDefinition = function(model) {
	return new As25TestCaseDefinition(model);
}

As25Factory.prototype.getMockDefinition = function(model) {
	return new MockDefinition(model);
}

As25Factory.prototype.getTestSuiteDefinition = function() {
	return new As25TestSuiteDefinition();
}

//--------------------------------------

var As2Factory = function() {
}

As2Factory.prototype.type = "ActionScript 2.0";

As2Factory.prototype.getClassDefinition = function(model) {
	return new ClassDefinition(model);
}

As2Factory.prototype.getTestCaseDefinition = function(model) {
	return new TestCaseDefinition(model);
}

As2Factory.prototype.getMockDefinition = function(model) {
	return new MockDefinition(model);
}

As2Factory.prototype.getTestSuiteDefinition = function() {
	return new TestSuiteDefinition();
}

//--------------------------------------

var As3Factory = function() {
}

As3Factory.prototype.type = "ActionScript 3.0";

As3Factory.prototype.getClassDefinition = function(model) {
	return new As3ClassDefinition(model);
}

As3Factory.prototype.getTestCaseDefinition = function(model) {
	return new As3TestCaseDefinition(model);
}

As3Factory.prototype.getMockDefinition = function(model) {
	return new As3MockDefinition(model);
}

As3Factory.prototype.getTestSuiteDefinition = function() {
	return new As3TestSuiteDefinition();
}

