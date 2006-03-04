
var ClassConstructor = function() {
}

ClassConstructor.prototype = new Object();
ClassConstructor.prototype.modifier = "public";

ClassConstructor.prototype.setModifier = function(modifierCode) {
	this.modifier = ClassModel.getConstructorLabel(modifierCode);
}

ClassConstructor.prototype.setClassName = function(name) {
	this.name = name;
}

ClassConstructor.prototype.toString = function() {
	var str = "";
	if(this.modifier == "singleton") {
		str += "\tprivate static var instance:" + this.name + ";\n\n"
		str += "\tprivate function " + this.name + "() {\n\t}\n\n";
		str += "\tpublic static function create():" + this.name + " {\n";
		str += "\t\tif(" + this.name + ".instance == undefined) {\n";
		str += "\t\t\t" + this.name + ".instance = new " + this.name + "();\n";
		str += "\t\t}\n";
		str += "\t\treturn " + this.name + ".instance;\n";
		str += "\t}\n\n";
		str += "\tpublic static function destroy():Void {\n";
		str += "\t\tdelete " + this.name + ".instance;\n";
		str += "\t}\n";

	} else {
		str += "\n\t" + this.modifier + " function " + this.name + "() {\n\t}\n";
	}
	return str;
}
