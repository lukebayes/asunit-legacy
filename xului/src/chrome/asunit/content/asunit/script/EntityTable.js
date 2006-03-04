
var EntityTable = function() {
	this.init();
}

EntityTable.prototype.items;
EntityTable.prototype.isInterface = false;

EntityTable.prototype.init = function() {
	this.items = new Array();
}

EntityTable.prototype.addItem = function(entity) {
	this.items.push(entity);
}

EntityTable.prototype.getAllItems = function() {
	var result = new Array();
	var ln = this.items.length;
	for(var i = 0; i < ln; i++) {
		if(this.items[i] == undefined) {
			continue;
		}
		result.push(this.items[i]);
	}
	return result;
}

EntityTable.prototype.getLength = function() {
	return this.items.length;
}

EntityTable.prototype.setIsInterface = function(isInf) {
	this.isInterface = isInf;
}

EntityTable.prototype.getInterfacesBySubstring = function(str) {
	var result = new Array();
	var str = str.toLowerCase();
	var ln = this.items.length;
	var item;
	for(var i = 0; i < ln; i++) {
		item = this.items[i];
		if(cclass.isInterfaceByConvention(item.getName())) {
			var name = item.getLowerCaseClassName();
			if(name.indexOf(str) > -1) {
				result.push(item);
			}
		}
	}

	return result;
}

EntityTable.prototype.getItemsBySubstring = function(str) {
	try {
		if(this.isInterface) {
			return this.getInterfacesBySubstring(str);
		}

		if(str == "") {
			return this.getAllItems();
		}
		var result = new Array();
		var str = str.toLowerCase();
		var ln = this.items.length;
		for(var i = 1; i < ln; i++) {
			var name = this.items[i].getLowerCaseClassName();
			if(name.indexOf(str) > -1) {
				result.push(this.items[i]);
			}
		}

		return result;
	}
	catch(e) {
		alert("EntityTable.getItems[" + i + "]: " + e);
	}
}

EntityTable.prototype.sort = function() {
	this.items.sort();
}

EntityTable.prototype.toString = function() {
	this.items.sort();
	var str = "";
//	str += this.items.length + " items:";
	for(var i in this.items) {
		str += this.items[i].getName() + "=" + this.items[i].getClassName() + "\n";
	}
	return str;
}
