
var As3ClassConstructor = function() {
}

As3ClassConstructor.prototype = new ClassConstructor();
As3ClassConstructor.prototype.modifier = "public";

As3ClassConstructor.prototype.setModifier = function(modifierCode) {
}

As3ClassConstructor.prototype.toString = function() {
	var str = "\n\t\t" + this.modifier + " function " + this.name + "() {\n";
	str += "\t\t}";
	return str;
}
