
var As3MockDefinition = function(initObj) {
	this.init(initObj);
}

As3MockDefinition.prototype = new As3ClassDefinition();

As3MockDefinition.prototype.config;

As3MockDefinition.prototype.init = function(model) {
	this.__proto__.init(model);

	this.setFullName(model.getMockName());
	this.header.removeImport(model.getSuperClassName());
	this.setSuperClass(model.getClassName());
	this.constr.setModifier(ClassModel.PUBLIC_CONSTRUCTOR);
	this.classSerializer.setClassName(model.getMockName());
	this.removeInterfaces(model.getInterfaces());
}
