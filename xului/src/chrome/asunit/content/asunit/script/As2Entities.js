
var As2Entities = function() {
	this.init();
}

As2Entities.prototype = new Object();
As2Entities.prototype.items;

As2Entities.prototype.getItems = function() {
	return this.items;
}

As2Entities.prototype.init = function() {
	this.items = new Array();
	this.items.push(new StubEntity("Accessibility", "Accessibility"));
	this.items.push(new StubEntity("Array", "Array"));
	this.items.push(new StubEntity("AsBroadcaster", "AsBroadcaster"));
	this.items.push(new StubEntity("AsUnit", "com.asunit.framework.AsUnit"));
	this.items.push(new StubEntity("Assert", "com.asunit.framework.Assert"));
	this.items.push(new StubEntity("Assertion", "com.asunit.framework.Assertion"));
	this.items.push(new StubEntity("Boolean", "Boolean"));
	this.items.push(new StubEntity("Button", "Button"));
	this.items.push(new StubEntity("Camera", "Camera"));
	this.items.push(new StubEntity("Color", "Color"));
	this.items.push(new StubEntity("Comparable", "com.asunit.util.Comparable"));
	this.items.push(new StubEntity("ContextMenu", "ContextMenu"));
	this.items.push(new StubEntity("ContextMenuItem", "ContextMenuItem"));
	this.items.push(new StubEntity("CustomActions", "CustomActions"));
	this.items.push(new StubEntity("Date", "Date"));
	this.items.push(new StubEntity("Enumeration", "Enumeration"));
	this.items.push(new StubEntity("Error", "Error"));
	this.items.push(new StubEntity("EventListener", "com.asunit.util.EventListener"));
	this.items.push(new StubEntity("EventSource", "com.asunit.util.EventSource"));
	this.items.push(new StubEntity("File", "File"));
	this.items.push(new StubEntity("FontName", "FontName"));
	this.items.push(new StubEntity("Function", "Function"));
	this.items.push(new StubEntity("FunctionArguments", "FunctionArguments"));
	this.items.push(new StubEntity("Key", "Key"));
	this.items.push(new StubEntity("LoadVars", "LoadVars"));
	this.items.push(new StubEntity("LocalConnClient", "com.asunit.util.LocalConnClient"));
	this.items.push(new StubEntity("LocalConnGateway", "com.asunit.util.LocalConnGateway"));
	this.items.push(new StubEntity("LocalConnServer", "com.asunit.util.LocalConnServer"));
	this.items.push(new StubEntity("LocalConnection", "LocalConnection"));
	this.items.push(new StubEntity("LocalMessageBroker", "com.asunit.util.LocalMessageBroker"));
	this.items.push(new StubEntity("LocalOutputPanel", "com.asunit.controls.LocalOutputPanel"));
	this.items.push(new StubEntity("LocalOutputPanelTest", "com.asunit.controls.LocalOutputPanelTest"));
	this.items.push(new StubEntity("LocalOutputPanelTextArea", "com.asunit.controls.LocalOutputPanelTextArea"));
	this.items.push(new StubEntity("LocalOutputPanelTextAreaTest", "com.asunit.controls.LocalOutputPanelTextAreaTest"));
	this.items.push(new StubEntity("LocalOutputPanelTitleBar", "com.asunit.controls.LocalOutputPanelTitleBar"));
	this.items.push(new StubEntity("Main", "com.asunit.ui.Main"));
	this.items.push(new StubEntity("Math", "Math"));
	this.items.push(new StubEntity("Microphone", "Microphone"));
	this.items.push(new StubEntity("Mouse", "Mouse"));
	this.items.push(new StubEntity("MovieClip", "MovieClip"));
	this.items.push(new StubEntity("MovieClipLoader", "MovieClipLoader"));
	this.items.push(new StubEntity("NetConnection", "NetConnection"));
	this.items.push(new StubEntity("NetStream", "NetStream"));
	this.items.push(new StubEntity("Number", "Number"));
	this.items.push(new StubEntity("Object", "Object"));
	this.items.push(new StubEntity("ObjectID", "ObjectID"));
	this.items.push(new StubEntity("Observable", "com.asunit.util.Observable"));
	this.items.push(new StubEntity("PrintJob", "PrintJob"));
	this.items.push(new StubEntity("Rectangle", "com.asunit.controls.shapes.Rectangle"));
	this.items.push(new StubEntity("Reflection", "com.asunit.framework.Reflection"));
	this.items.push(new StubEntity("RemoteVersion", "com.asunit.ui.RemoteVersion"));
	this.items.push(new StubEntity("ResizeHandle", "com.asunit.controls.ResizeHandle"));
	this.items.push(new StubEntity("ScrollArrow", "com.asunit.controls.ScrollArrow"));
	this.items.push(new StubEntity("ScrollHandle", "com.asunit.controls.ScrollHandle"));
	this.items.push(new StubEntity("ScrollListener", "com.asunit.controls.ScrollListener"));
	this.items.push(new StubEntity("Selection", "Selection"));
	this.items.push(new StubEntity("SharedObject", "SharedObject"));
	this.items.push(new StubEntity("Sound", "Sound"));
	this.items.push(new StubEntity("Stage", "Stage"));
	this.items.push(new StubEntity("String", "String"));
	this.items.push(new StubEntity("StyleSheet", "TextField.StyleSheet"));
	this.items.push(new StubEntity("SuccessMeter", "com.asunit.ui.SuccessMeter"));
	this.items.push(new StubEntity("Sys", "Sys"));
	this.items.push(new StubEntity("System", "System"));
	this.items.push(new StubEntity("Test", "com.asunit.framework.Test"));
	this.items.push(new StubEntity("TestCase", "com.asunit.framework.TestCase"));
	this.items.push(new StubEntity("TestCaseXml", "com.asunit.framework.TestCaseXml"));
	this.items.push(new StubEntity("TestFailure", "com.asunit.framework.TestFailure"));
	this.items.push(new StubEntity("TestResult", "com.asunit.framework.TestResult"));
	this.items.push(new StubEntity("TestRunner", "com.asunit.framework.TestRunner"));
	this.items.push(new StubEntity("TestSetup", "com.asunit.framework.TestSetup"));
	this.items.push(new StubEntity("TestSuite", "com.asunit.framework.TestSuite"));
	this.items.push(new StubEntity("TextField", "TextField"));
	this.items.push(new StubEntity("TextFile", "com.asunit.util.TextFile"));
	this.items.push(new StubEntity("TextFormat", "TextFormat"));
	this.items.push(new StubEntity("TextScroller", "com.asunit.controls.TextScroller"));
	this.items.push(new StubEntity("TextSnapshot", "TextSnapshot"));
	this.items.push(new StubEntity("Triangle", "com.asunit.controls.shapes.Triangle"));
	this.items.push(new StubEntity("URI", "URI"));
	this.items.push(new StubEntity("Video", "Video"));
	this.items.push(new StubEntity("XML", "XML"));
	this.items.push(new StubEntity("XMLNode", "XMLNode"));
	this.items.push(new StubEntity("XMLSocket", "XMLSocket"));
	this.items.push(new StubEntity("XMLUI", "XMLUI"));
	this.items.push(new StubEntity("capabilities", "System.capabilities"));
	this.items.push(new StubEntity("security", "System.security"));
}

