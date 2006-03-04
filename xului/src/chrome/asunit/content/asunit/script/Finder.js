
var Finder = function() {
}

Finder.prototype = new Object();
Finder.RESULT_STRING_INTRO = "Found ";
Finder.RESULT_STRING_MIDDLE = " items ";
Finder.RESULT_STRING_CLOSE = "matching ";
Finder.prototype.nameInput;
Finder.prototype.finderList;
Finder.prototype.listContainer;
Finder.prototype.entityTable;
Finder.prototype.resultLabel;
Finder.prototype.lastSearchString;
Finder.prototype.footerText;

Finder.prototype.init = function() {
	this.buildElementReferences();
	this.entityTable = window.opener.model.getEntityTable();
	this.nameInput.select();
	addEventListener("keypress", this.onKeyPressed, true);
	this.onTextChanged();
}

Finder.prototype.buildElementReferences = function() {
	this.listContainer = document.getElementById("listContainer");
	this.footerText    = document.getElementById("footerText");
	this.nameInput     = document.getElementById("nameInput");
	this.resultLabel   = document.getElementById("resultLabel");
}

Finder.prototype.onTextChanged = function() {
	var arr;
	var str = this.nameInput.value;
	if(str != this.lastSearchString) {
		this.lastSearchString = str;
		arr = this.entityTable.getItemsBySubstring(str);
		this.updateList(arr, str);
	}
}

Finder.prototype.getFooterLabel = function() {
	return "Interfaces are shown in blue and are identified by the following space-delimited Regular Expressions " + this.getInterfaceExpression();
}

Finder.prototype.getInterfaceExpression = function() {
	return window.opener.CreateClass.INTERFACE_CONVENTIONS;
}

Finder.prototype.onSubmit = function() {
	var item = this.finderList.selectedItem;
	var str = item.getAttribute("value");
	window.opener.cclass.onFinderInput(str);
	window.close();
}

Finder.prototype.onCancel = function() {
	window.close();
}

Finder.prototype.buildEmptyList = function() {

	if(this.listContainer.childNodes.length > 0) {
		this.listContainer.removeChild(this.listContainer.firstChild);
	}

	var list = document.createElement("listbox");
	list.setAttribute("flex", 1);

	var header = this.getListHeader();
	var cols = this.getListCols();
	list.appendChild(header);
	list.appendChild(cols);
	this.listContainer.appendChild(list);
	this.finderList = list;
	return list;
}

Finder.prototype.getListCols = function() {
//	<listcols id="listCols">
//		<listcol flex="1"/>
//		<listcol flex="2"/>
//	</listcols>
	var cols = document.createElement("listcols");
	var col1 = document.createElement("listcol");
	var col2 = document.createElement("listcol");
	col1.setAttribute("flex", 1);
	col2.setAttribute("flex", 2);
	cols.appendChild(col1);
	cols.appendChild(col2);
	return cols;
}

Finder.prototype.getListHeader = function() {
//	<listhead id="listHeader">
//		<listheader label="Name"/>
//		<listheader label="Full Name"/>
//	</listhead>
	var head = document.createElement("listhead");
	var col1 = document.createElement("listheader");
	var col2 = document.createElement("listheader");
	col1.setAttribute("label", "Name");
	col2.setAttribute("label", "Full Name");
	head.appendChild(col1);
	head.appendChild(col2);
	return head;
}

Finder.prototype.updateList = function(arr, str) {

	var list = this.buildEmptyList();
	var name = "";
	var fullName = "";
	var isInf = false;
	var item;
	var cell1;
	var cell2;

	var resCount = arr.length;

	for(var i = 0; i < resCount; i++) {
		item	  = document.createElement("listitem");
		cell1	  = document.createElement("listcell");
		cell2	  = document.createElement("listcell");
		name  	  = arr[i].getName();
		fullName  = arr[i].getClassName();

		isInf = window.opener.cclass.isInterfaceByConvention(name);
		if(isInf) {
			cell1.setAttribute("class", "listItemInterface");
		} else {
			cell1.setAttribute("class", "listItemClass");
		}

		cell1.setAttribute("label", name);
		cell2.setAttribute("label", fullName);

		item.setAttribute("value", fullName);
		item.appendChild(cell1);
		item.appendChild(cell2);
		list.appendChild(item);
	}

	var res = Finder.RESULT_STRING_INTRO + resCount + Finder.RESULT_STRING_MIDDLE;
	if(str != "") {
		res += Finder.RESULT_STRING_CLOSE + "\"" + str + "\"";
	}

	this.resultLabel.value = res;
	this.focusNameInput();
}

Finder.prototype.onKeyPressed = function(keyEvent) {
	var focusedElement = document.commandDispatcher.focusedElement;
	var id = focusedElement.getAttribute("id");
	while(id == null || id == "") {
		focusedElement = focusedElement.parentNode;
		id = focusedElement.getAttribute("id");
	}

	var code = keyEvent.keyCode;
	var input = finder.nameInput;
	var list = finder.finderList;

	if(code == keyEvent.DOM_VK_ENTER || code == keyEvent.DOM_VK_RETURN) {
		finder.onSubmit();
	} else if(code == 0 && id != input.id) {
		var character = String.fromCharCode(keyEvent.charCode);
		if(character != "" && character != null) {
			input.value += character;
			finder.onTextChanged(input);
		}
	} else if(code != 0 && id == input.id) {
		if(code == keyEvent.DOM_VK_UP) {
			list.selectedIndex--;
		} else if(code == keyEvent.DOM_VK_DOWN) {
			list.selectedIndex++;
		}
	}
}

Finder.prototype.focusNameInput = function() {
	this.nameInput.focus();
	this.nameInput.selectionStart = this.nameInput.textLength;

	if(this.finderList.selectedIndex == -1) {
		this.finderList.selectedIndex = 0;
	}
}

var finder = new Finder();
