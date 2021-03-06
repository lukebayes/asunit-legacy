
var As3Entities = function() {
	this.init();
}

As3Entities.prototype = new Object();
As3Entities.prototype.items;

As3Entities.prototype.getItems = function() {
	return this.items;
}

As3Entities.prototype.init = function() {
	this.items = new Array();
	this.items.push(new StubEntity("AS2Interop", "flash.util.AS2Interop"));
	this.items.push(new StubEntity("AS2MovieClip", "flash.util.AS2MovieClip"));
	this.items.push(new StubEntity("Accessibility", "flash.accessibility.Accessibility"));
	this.items.push(new StubEntity("AccessibilityImplementation", "flash.accessibility.AccessibilityImplementation"));
	this.items.push(new StubEntity("AccessibilityProperties", "flash.accessibility.AccessibilityProperties"));
	this.items.push(new StubEntity("ActivityEvent", "flash.events.ActivityEvent"));
	this.items.push(new StubEntity("AntiAliasType", "flash.text.AntiAliasType"));
	this.items.push(new StubEntity("ApplicationDomain", "flash.system.ApplicationDomain"));
	this.items.push(new StubEntity("ArgumentError", "ArgumentError"));
	this.items.push(new StubEntity("Array", "Array"));
	this.items.push(new StubEntity("BevelFilter", "flash.filters.BevelFilter"));
	this.items.push(new StubEntity("Bitmap", "flash.display.Bitmap"));
	this.items.push(new StubEntity("BitmapData", "flash.display.BitmapData"));
	this.items.push(new StubEntity("BitmapDataChannel", "flash.display.BitmapDataChannel"));
	this.items.push(new StubEntity("BitmapFilter", "flash.filters.BitmapFilter"));
	this.items.push(new StubEntity("BitmapFilterQuality", "flash.filters.BitmapFilterQuality"));
	this.items.push(new StubEntity("BitmapFilterType", "flash.filters.BitmapFilterType"));
	this.items.push(new StubEntity("BlendMode", "flash.display.BlendMode"));
	this.items.push(new StubEntity("BlurFilter", "flash.filters.BlurFilter"));
	this.items.push(new StubEntity("Boolean", "Boolean"));
	this.items.push(new StubEntity("ByteArray", "flash.util.ByteArray"));
	this.items.push(new StubEntity("Camera", "flash.media.Camera"));
	this.items.push(new StubEntity("Capabilities", "flash.system.Capabilities"));
	this.items.push(new StubEntity("CapsStyle", "flash.display.CapsStyle"));
	this.items.push(new StubEntity("Class", "Class"));
	this.items.push(new StubEntity("ColorMatrixFilter", "flash.filters.ColorMatrixFilter"));
	this.items.push(new StubEntity("ColorTransform", "flash.geom.ColorTransform"));
	this.items.push(new StubEntity("ColorType", "flash.text.ColorType"));
	this.items.push(new StubEntity("ContextMenu", "flash.ui.ContextMenu"));
	this.items.push(new StubEntity("ContextMenuBuiltInItems", "flash.ui.ContextMenuBuiltInItems"));
	this.items.push(new StubEntity("ContextMenuEvent", "flash.events.ContextMenuEvent"));
	this.items.push(new StubEntity("ContextMenuItem", "flash.ui.ContextMenuItem"));
	this.items.push(new StubEntity("ConvolutionFilter", "flash.filters.ConvolutionFilter"));
	this.items.push(new StubEntity("CustomActions", "macromedia.util.CustomActions"));
	this.items.push(new StubEntity("DataEvent", "flash.events.DataEvent"));
	this.items.push(new StubEntity("DataFormat", "flash.net.DataFormat"));
	this.items.push(new StubEntity("Date", "Date"));
	this.items.push(new StubEntity("DefinitionError", "DefinitionError"));
	this.items.push(new StubEntity("DisplacementMapFilter", "flash.filters.DisplacementMapFilter"));
	this.items.push(new StubEntity("DisplacementMapFilterMode", "flash.filters.DisplacementMapFilterMode"));
	this.items.push(new StubEntity("DisplayObject", "flash.display.DisplayObject"));
	this.items.push(new StubEntity("DisplayObjectContainer", "flash.display.DisplayObjectContainer"));
	this.items.push(new StubEntity("DropShadowFilter", "flash.filters.DropShadowFilter"));
	this.items.push(new StubEntity("EOFError", "flash.errors.EOFError"));
	this.items.push(new StubEntity("Endian", "flash.util.Endian"));
	this.items.push(new StubEntity("Error", "Error"));
	this.items.push(new StubEntity("ErrorEvent", "flash.events.ErrorEvent"));
	this.items.push(new StubEntity("EvalError", "EvalError"));
	this.items.push(new StubEntity("Event", "flash.events.Event"));
	this.items.push(new StubEntity("EventDispatcher", "flash.events.EventDispatcher"));
	this.items.push(new StubEntity("EventPhase", "flash.events.EventPhase"));
	this.items.push(new StubEntity("EventRoot", "flash.events.EventRoot"));
	this.items.push(new StubEntity("ExternalInterface", "flash.external.ExternalInterface"));
	this.items.push(new StubEntity("FSCommand", "flash.system.FSCommand"));
	this.items.push(new StubEntity("FileFilter", "flash.net.FileFilter"));
	this.items.push(new StubEntity("FileReference", "flash.net.FileReference"));
	this.items.push(new StubEntity("FileReferenceList", "flash.net.FileReferenceList"));
	this.items.push(new StubEntity("FocusEvent", "flash.events.FocusEvent"));
	this.items.push(new StubEntity("Font", "flash.display.Font"));
	this.items.push(new StubEntity("FontStyle", "flash.text.FontStyle"));
	this.items.push(new StubEntity("Function", "Function"));
	this.items.push(new StubEntity("GlowFilter", "flash.filters.GlowFilter"));
	this.items.push(new StubEntity("GradientBevelFilter", "flash.filters.GradientBevelFilter"));
	this.items.push(new StubEntity("GradientGlowFilter", "flash.filters.GradientGlowFilter"));
	this.items.push(new StubEntity("GradientType", "flash.display.GradientType"));
	this.items.push(new StubEntity("Graphics", "flash.display.Graphics"));
	this.items.push(new StubEntity("GridFitType", "flash.text.GridFitType"));
	this.items.push(new StubEntity("HTTPStatusEvent", "flash.events.HTTPStatusEvent"));
	this.items.push(new StubEntity("IDataInput", "flash.util.IDataInput"));
	this.items.push(new StubEntity("IDataOutput", "flash.util.IDataOutput"));
	this.items.push(new StubEntity("IEventDispatcher", "flash.events.IEventDispatcher"));
	this.items.push(new StubEntity("IExternalizable", "flash.util.IExternalizable"));
	this.items.push(new StubEntity("IME", "flash.system.IME"));
	this.items.push(new StubEntity("IMEConversionMode", "flash.system.IMEConversionMode"));
	this.items.push(new StubEntity("IMEEvent", "flash.events.IMEEvent"));
	this.items.push(new StubEntity("IOError", "flash.errors.IOError"));
	this.items.push(new StubEntity("IOErrorEvent", "flash.events.IOErrorEvent"));
	this.items.push(new StubEntity("IllegalOperationError", "flash.errors.IllegalOperationError"));
	this.items.push(new StubEntity("Infinity", "Infinity"));
	this.items.push(new StubEntity("InteractiveObject", "flash.display.InteractiveObject"));
	this.items.push(new StubEntity("InterpolationMethod", "flash.display.InterpolationMethod"));
	this.items.push(new StubEntity("JointStyle", "flash.display.JointStyle"));
	this.items.push(new StubEntity("KeyLocation", "flash.ui.KeyLocation"));
	this.items.push(new StubEntity("Keyboard", "flash.ui.Keyboard"));
	this.items.push(new StubEntity("KeyboardEvent", "flash.events.KeyboardEvent"));
	this.items.push(new StubEntity("LineScaleMode", "flash.display.LineScaleMode"));
	this.items.push(new StubEntity("Loader", "flash.display.Loader"));
	this.items.push(new StubEntity("LoaderInfo", "flash.display.LoaderInfo"));
	this.items.push(new StubEntity("LocalConnection", "flash.net.LocalConnection"));
	this.items.push(new StubEntity("MMExecute", "macromedia.util.MMExecute"));
	this.items.push(new StubEntity("Math", "Math"));
	this.items.push(new StubEntity("Matrix", "flash.geom.Matrix"));
	this.items.push(new StubEntity("MemoryError", "flash.errors.MemoryError"));
	this.items.push(new StubEntity("Microphone", "flash.media.Microphone"));
	this.items.push(new StubEntity("MorphShape", "flash.display.MorphShape"));
	this.items.push(new StubEntity("Mouse", "flash.ui.Mouse"));
	this.items.push(new StubEntity("MouseEvent", "flash.events.MouseEvent"));
	this.items.push(new StubEntity("MovieClip", "flash.display.MovieClip"));
	this.items.push(new StubEntity("NaN", "NaN"));
	this.items.push(new StubEntity("Namespace", "Namespace"));
	this.items.push(new StubEntity("NetConnection", "flash.net.NetConnection"));
	this.items.push(new StubEntity("NetStatusEvent", "flash.events.NetStatusEvent"));
	this.items.push(new StubEntity("NetStream", "flash.net.NetStream"));
	this.items.push(new StubEntity("Number", "Number"));
	this.items.push(new StubEntity("Object", "Object"));
	this.items.push(new StubEntity("ObjectEncoding", "flash.net.ObjectEncoding"));
	this.items.push(new StubEntity("ObjectInput", "flash.util.ObjectInput"));
	this.items.push(new StubEntity("ObjectOutput", "flash.util.ObjectOutput"));
	this.items.push(new StubEntity("Orientation", "flash.print.Orientation"));
	this.items.push(new StubEntity("PixelSnapping", "flash.display.PixelSnapping"));
	this.items.push(new StubEntity("Point", "flash.geom.Point"));
	this.items.push(new StubEntity("PolicyFileEvent", "flash.events.PolicyFileEvent"));
	this.items.push(new StubEntity("PrintJob", "flash.print.PrintJob"));
	this.items.push(new StubEntity("ProductManager", "macromedia.util.ProductManager"));
	this.items.push(new StubEntity("ProgressEvent", "flash.events.ProgressEvent"));
	this.items.push(new StubEntity("Proxy", "flash.util.Proxy"));
	this.items.push(new StubEntity("QName", "QName"));
	this.items.push(new StubEntity("RangeError", "RangeError"));
	this.items.push(new StubEntity("Rectangle", "flash.geom.Rectangle"));
	this.items.push(new StubEntity("ReferenceError", "ReferenceError"));
	this.items.push(new StubEntity("RegExp", "RegExp"));
	this.items.push(new StubEntity("Responder", "flash.net.Responder"));
	this.items.push(new StubEntity("ScriptTimeoutError", "flash.errors.ScriptTimeoutError"));
	this.items.push(new StubEntity("Security", "flash.system.Security"));
	this.items.push(new StubEntity("SecurityError", "SecurityError"));
	this.items.push(new StubEntity("SecurityErrorEvent", "flash.events.SecurityErrorEvent"));
	this.items.push(new StubEntity("SecurityPanel", "flash.system.SecurityPanel"));
	this.items.push(new StubEntity("SetIntervalTimer", "flash.util.SetIntervalTimer"));
	this.items.push(new StubEntity("Shape", "flash.display.Shape"));
	this.items.push(new StubEntity("SharedObject", "flash.net.SharedObject"));
	this.items.push(new StubEntity("SimpleButton", "flash.display.SimpleButton"));
	this.items.push(new StubEntity("Socket", "flash.net.Socket"));
	this.items.push(new StubEntity("Sound", "flash.media.Sound"));
	this.items.push(new StubEntity("SoundChannel", "flash.media.SoundChannel"));
	this.items.push(new StubEntity("SoundMixer", "flash.media.SoundMixer"));
	this.items.push(new StubEntity("SoundTransform", "flash.media.SoundTransform"));
	this.items.push(new StubEntity("SpreadMethod", "flash.display.SpreadMethod"));
	this.items.push(new StubEntity("Sprite", "flash.display.Sprite"));
	this.items.push(new StubEntity("StackOverflowError", "flash.errors.StackOverflowError"));
	this.items.push(new StubEntity("Stage", "flash.display.Stage"));
	this.items.push(new StubEntity("StageAlign", "flash.display.StageAlign"));
	this.items.push(new StubEntity("StageQuality", "flash.display.StageQuality"));
	this.items.push(new StubEntity("StageScaleMode", "flash.display.StageScaleMode"));
	this.items.push(new StubEntity("StaticText", "flash.display.StaticText"));
	this.items.push(new StubEntity("StatusEvent", "flash.events.StatusEvent"));
	this.items.push(new StubEntity("String", "String"));
	this.items.push(new StubEntity("StringBuilder", "flash.util.StringBuilder"));
	this.items.push(new StubEntity("StyleSheet", "flash.text.StyleSheet"));
	this.items.push(new StubEntity("SyncEvent", "flash.events.SyncEvent"));
	this.items.push(new StubEntity("SyntaxError", "SyntaxError"));
	this.items.push(new StubEntity("System", "flash.system.System"));
	this.items.push(new StubEntity("TextEvent", "flash.events.TextEvent"));
	this.items.push(new StubEntity("TextExtent", "flash.text.TextExtent"));
	this.items.push(new StubEntity("TextField", "flash.display.TextField"));
	this.items.push(new StubEntity("TextFieldAutoSize", "flash.display.TextFieldAutoSize"));
	this.items.push(new StubEntity("TextFieldType", "flash.display.TextFieldType"));
	this.items.push(new StubEntity("TextFormat", "flash.text.TextFormat"));
	this.items.push(new StubEntity("TextFormatAlign", "flash.text.TextFormatAlign"));
	this.items.push(new StubEntity("TextFormatDisplay", "flash.text.TextFormatDisplay"));
	this.items.push(new StubEntity("TextLineMetrics", "flash.text.TextLineMetrics"));
	this.items.push(new StubEntity("TextRenderer", "flash.text.TextRenderer"));
	this.items.push(new StubEntity("TextRun", "flash.text.TextRun"));
	this.items.push(new StubEntity("TextSnapshot", "flash.text.TextSnapshot"));
	this.items.push(new StubEntity("Timer", "flash.util.Timer"));
	this.items.push(new StubEntity("TimerEvent", "flash.events.TimerEvent"));
	this.items.push(new StubEntity("Transform", "flash.geom.Transform"));
	this.items.push(new StubEntity("TypeError", "TypeError"));
	this.items.push(new StubEntity("URIError", "URIError"));
	this.items.push(new StubEntity("URLLoader", "flash.net.URLLoader"));
	this.items.push(new StubEntity("URLRequest", "flash.net.URLRequest"));
	this.items.push(new StubEntity("URLRequestHeader", "flash.net.URLRequestHeader"));
	this.items.push(new StubEntity("URLStream", "flash.net.URLStream"));
	this.items.push(new StubEntity("URLVariables", "flash.net.URLVariables"));
	this.items.push(new StubEntity("UninitializedError", "UninitializedError"));
	this.items.push(new StubEntity("VerifyError", "VerifyError"));
	this.items.push(new StubEntity("Video", "flash.media.Video"));
	this.items.push(new StubEntity("XML", "XML"));
	this.items.push(new StubEntity("XMLDocument", "flash.xml.XMLDocument"));
	this.items.push(new StubEntity("XMLList", "XMLList"));
	this.items.push(new StubEntity("XMLNode", "flash.xml.XMLNode"));
	this.items.push(new StubEntity("XMLNodeType", "flash.xml.XMLNodeType"));
	this.items.push(new StubEntity("XMLParser", "flash.xml.XMLParser"));
	this.items.push(new StubEntity("XMLSocket", "flash.net.XMLSocket"));
	this.items.push(new StubEntity("XMLTag", "flash.xml.XMLTag"));
	this.items.push(new StubEntity("XMLUI", "macromedia.util.XMLUI"));
	this.items.push(new StubEntity("clearInterval", "flash.util.clearInterval"));
	this.items.push(new StubEntity("clearTimeout", "flash.util.clearTimeout"));
	this.items.push(new StubEntity("decodeURI", "decodeURI"));
	this.items.push(new StubEntity("decodeURIComponent", "decodeURIComponent"));
	this.items.push(new StubEntity("describeType", "flash.util.describeType"));
	this.items.push(new StubEntity("encodeURI", "encodeURI"));
	this.items.push(new StubEntity("encodeURIComponent", "encodeURIComponent"));
	this.items.push(new StubEntity("enterDebugger", "flash.debugger.enterDebugger"));
	this.items.push(new StubEntity("escape", "escape"));
	this.items.push(new StubEntity("flash_proxy", "flash.util.flash_proxy"));
	this.items.push(new StubEntity("fscommand", "flash.system.fscommand"));
	this.items.push(new StubEntity("getClassByAlias", "flash.net.getClassByAlias"));
	this.items.push(new StubEntity("getClassByName", "flash.util.getClassByName"));
	this.items.push(new StubEntity("getQualifiedClassName", "flash.util.getQualifiedClassName"));
	this.items.push(new StubEntity("getTimer", "flash.util.getTimer"));
	this.items.push(new StubEntity("heapDump", "flash.profiler.heapDump"));
	this.items.push(new StubEntity("int", "int"));
	this.items.push(new StubEntity("isFinite", "isFinite"));
	this.items.push(new StubEntity("isNaN", "isNaN"));
	this.items.push(new StubEntity("isXMLName", "isXMLName"));
	this.items.push(new StubEntity("navigateToURL", "flash.net.navigateToURL"));
	this.items.push(new StubEntity("parseFloat", "parseFloat"));
	this.items.push(new StubEntity("parseInt", "parseInt"));
	this.items.push(new StubEntity("profile", "flash.profiler.profile"));
	this.items.push(new StubEntity("registerClassAlias", "flash.net.registerClassAlias"));
	this.items.push(new StubEntity("sendToURL", "flash.net.sendToURL"));
	this.items.push(new StubEntity("setInterval", "flash.util.setInterval"));
	this.items.push(new StubEntity("setTimeout", "flash.util.setTimeout"));
	this.items.push(new StubEntity("shl", "flash.util.shl"));
	this.items.push(new StubEntity("showRedrawRegions", "flash.profiler.showRedrawRegions"));
	this.items.push(new StubEntity("shr", "flash.util.shr"));
	this.items.push(new StubEntity("trace", "flash.util.trace"));
	this.items.push(new StubEntity("uint", "uint"));
	this.items.push(new StubEntity("unescape", "unescape"));
}
