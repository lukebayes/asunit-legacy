
var MockDefinition = function(initObj) {
	this.init(initObj);
}

MockDefinition.prototype = new ClassDefinition();

MockDefinition.prototype.config;

MockDefinition.prototype.init = function(model) {
	this.__proto__.init(model);

	this.setFullName(model.getMockName());
	this.header.removeImport(model.getSuperClassName());
	this.setSuperClass(model.getClassName());
	this.constr.setModifier(ClassModel.PUBLIC_CONSTRUCTOR);
	this.classSerializer.setClassName(model.getMockName());
	this.removeInterfaces(model.getInterfaces());
}
