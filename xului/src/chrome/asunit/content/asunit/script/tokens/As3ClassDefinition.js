
var As3ClassDefinition = function(initObj) {
	if(initObj != null) {
		this.init(initObj);
	}
}

As3ClassDefinition.prototype = new ClassDefinition();

As3ClassDefinition.prototype.initializeMembers = function() {
	this.header = new As3ClassHeader();
	this.declaration = new As3ClassDeclaration();
	this.body = new As3ClassBody();
	this.constr = new As3ClassConstructor();
	this.classSerializer = new As3ClassSerializable();
}

As3ClassDefinition.prototype.setPackage = function(packageName) {
	this.packageName = packageName;
	this.header.setPackage(packageName);
}
