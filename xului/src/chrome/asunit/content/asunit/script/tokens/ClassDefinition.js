
var ClassDefinition = function(initObj) {
	if(initObj != null) {
		this.init(initObj);
	}
}

ClassDefinition.prototype = new Object();
ClassDefinition.prototype.name;
ClassDefinition.prototype.packageName;
ClassDefinition.prototype.fullName;

ClassDefinition.prototype.header;
ClassDefinition.prototype.declaration;
ClassDefinition.prototype.constr;
ClassDefinition.prototype.functions;
ClassDefinition.prototype.body;
ClassDefinition.prototype.classSerializer;
ClassDefinition.prototype.interfaces;

ClassDefinition.prototype.isSerializable;

ClassDefinition.prototype.init = function(model) {
	this.initializeMembers();

	this.setFullName(model.getClassName());

	if(model.superClassName != "") {
		this.setSuperClass(model.getSuperClassName());
	}

	if(model.getAddPackagesPrefix() && model.getIsSerializable() && model.getSuperClassName() == "") {
		this.setSuperClass("MovieClip");
	}

	var infs = model.getInterfaces();
	if(infs.length > 0) {
		this.setInterfaces(infs);
	}

	this.constr.setModifier(model.getConstructorType());

	this.isSerializable = model.getIsSerializable();
	this.classSerializer.setClassName(this.fullName);
	this.classSerializer.setAddPackages(model.getAddPackagesPrefix());

}

ClassDefinition.prototype.initializeMembers = function() {
	this.header = new ClassHeader();
	this.declaration = new ClassDeclaration();
	this.body = new ClassBody();
	this.constr = new ClassConstructor();
	this.classSerializer = new ClassSerializable();
//	this.functions = new Array();
}

ClassDefinition.prototype.setName = function(name) {
	this.name = name;
}

ClassDefinition.prototype.getName = function() {
	return this.name;
}

ClassDefinition.prototype.setPackage = function(packageName) {
	this.packageName = packageName;
}

ClassDefinition.prototype.getPackage = function() {
	return this.packageName;
}

ClassDefinition.prototype.setFullName = function(fullName) {
	this.fullName = fullName;
	var arr = fullName.split(".");
	this.setName(arr.pop());
	this.setPackage(arr.join("."));
	this.constr.setClassName(this.getName());

	this.declaration.setClassName(this.fullName);
}

ClassDefinition.prototype.getFullName = function() {
	return this.fullName;
}

ClassDefinition.prototype.setSuperClass = function(name) {
	var arr = name.split(".");
	if(arr.length > 1) {
		this.header.addImport(name);
	}
	this.declaration.addSuperClass(arr.pop());
}

ClassDefinition.prototype.setInterfaces = function(interfaces) {
	var arr = interfaces;
	for(var i = 0; i < arr.length; i++) {
		if(arr[i] != "" && arr[i] != null) {
			this.header.addImport(arr[i]);
			this.declaration.addInterface(arr[i]);
		}
	}
}

ClassDefinition.prototype.removeInterfaces = function(interfaces) {
	this.declaration.clearInterfaces();
	for(var i = 0; i < interfaces.length; i++) {
		this.header.removeImport(interfaces[i]);
	}
}

ClassDefinition.prototype.toString = function() {
	try {
		var str = "";
		str += this.header.toString();
		str += this.declaration.toString();
		if(this.isSerializable) {
			str += this.classSerializer.getIntroduction();
		}

		str += this.constr.toString();

		if(this.isSerializable) {
			str += this.classSerializer.getConclusion();
		}
		str += this.body.toString();
		return str;
	} catch(e) {
		alert(e.toString());
	}
}
