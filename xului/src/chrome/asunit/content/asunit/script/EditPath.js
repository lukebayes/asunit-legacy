
var EditPath = function() {
}

EditPath.prototype.addBtn;
EditPath.prototype.editBtn;
EditPath.prototype.removeBtn;
EditPath.prototype.moveUpBtn;
EditPath.prototype.moveDownBtn;
EditPath.prototype.pathList;

EditPath.prototype.init = function() {
	this.buildElementReferences();
	this.setButtonsDisabled(true);
	this.buildList();
}

EditPath.prototype.buildElementReferences = function() {
	this.addBtn = document.getElementById("addButton");
	this.editBtn = document.getElementById("editButton");
	this.removeBtn = document.getElementById("removeButton");
	this.moveUpBtn = document.getElementById("moveUpButton");
	this.moveDownBtn = document.getElementById("moveDownButton");
	this.pathList = document.getElementById("pathListBox");
}

EditPath.prototype.buildList = function() {
	var pathString = window.opener.model.getClassPath();

	if(pathString == "") {
		return;
	}

	var pathArray = pathString.split(";");
	for(var i = 0; i < pathArray.length; i++) {
		if(pathArray[i] != "") {
			this.addItemToList(pathArray[i]);
		}
	}

	if(pathArray[0] != "") {
		this.pathList.selectedIndex = 0;
	}
}

EditPath.prototype.getListItemByLabel = function(oldLabel, newLabel) {
	var ln = this.pathList.getRowCount();
	for(var i = 0; i < ln; i++) {
		var item = this.pathList.getItemAtIndex(i);
		if(item.label == oldLabel) {
			return item;
		}
	}
	return null;
}

EditPath.prototype.addItemToList = function(label) {
	var item = document.createElement("listitem");
	item.setAttribute("label", label);
	this.pathList.appendChild(item);
	this.pathList.selectedIndex = this.pathList.getRowCount() - 1;
	return this.pathList.selectedIndex;
}

EditPath.prototype.onRemoveItem = function() {
	var lastIndex = this.pathList.selectedIndex;
	var item = this.pathList.selectedItem;
	this.pathList.removeChild(item);
	this.pathList.selectedIndex = Math.max(0, Math.min(this.pathList.getRowCount(), --lastIndex));
}

EditPath.prototype.onMoveItemUp = function() {
	var oldIndex = this.pathList.selectedIndex
	var newIndex = oldIndex-1;
	var itemToMove = this.pathList.removeItemAt(oldIndex);
	this.pathList.insertItemAt(newIndex, itemToMove.getAttribute("label"));
	this.pathList.selectedIndex = newIndex;
}

EditPath.prototype.onMoveItemDown = function() {
	var oldIndex = this.pathList.selectedIndex
	var newIndex = oldIndex++;
	var itemToMove = this.pathList.removeItemAt(oldIndex);
	this.pathList.insertItemAt(newIndex, itemToMove.getAttribute("label"));
	this.pathList.selectedIndex = ++newIndex;
	this.onListSelected(this.pathList);
}

EditPath.prototype.onAddItem = function() {
	var dir = this.chooseDirectory("");
	if(dir != "") {
		this.addItemToList(dir);
	}
}

EditPath.prototype.onEditItem = function() {
	var oldItem = this.pathList.selectedItem;
	var selectedDir = oldItem.getAttribute("label");
	var label = this.chooseDirectory(selectedDir);
	if(label != selectedDir) {
		var newItem = document.createElement("listitem");
		newItem.setAttribute("label", label);
		this.pathList.replaceChild(newItem, oldItem);
		this.pathList.selectedItem = newItem;
	}
}

EditPath.prototype.onListSelected = function(list) {
	if(list.selectedIndex == -1) {
		this.setButtonsDisabled(true);
	} else {
		this.setButtonsDisabled(false);
	}

	if(list.selectedIndex == 0) {
		this.moveUpBtn.setAttribute("disabled", true);
	} else if(list.selectedIndex >= (list.getRowCount()-1)) {
		this.moveDownBtn.setAttribute("disabled", true);
	}
}

EditPath.prototype.chooseDirectory = function(startDir) {
	var nsIFilePicker = Components.interfaces.nsIFilePicker;
	var fp = Components.classes["@mozilla.org/filepicker;1"].createInstance(nsIFilePicker);
	fp.init(window, "Select Directory", nsIFilePicker.modeGetFolder);
	var res = fp.show();

	if (res == nsIFilePicker.returnOK){
		return fp.file.path;
	}

	return startDir;
}

EditPath.prototype.setButtonsDisabled = function(isDisabled) {
	this.removeBtn.setAttribute("disabled", isDisabled);
	this.editBtn.setAttribute("disabled", isDisabled);
	this.moveUpBtn.setAttribute("disabled", isDisabled);
	this.moveDownBtn.setAttribute("disabled", isDisabled);
}

EditPath.prototype.onSubmit = function() {
	var str = this.toString();
	window.opener.model.setClassPath(str);
	window.close();
}

EditPath.prototype.onCancel = function() {
	window.close();
}

EditPath.prototype.toString = function() {
	var str = "";
	if(this.pathList.getRowCount() <= 0) {
		return str;
	}
	var item = this.pathList.getItemAtIndex(0);
	str = item.getAttribute("label");
	var ln = this.pathList.getRowCount();
	for(var i = 1; i < ln; i++) {
		item = this.pathList.getItemAtIndex(i);
		str += (";" + item.getAttribute("label"));
	}
	return str;
}

var epath = new EditPath();
