import asunit.framework.Test;import asunit.framework.TestFailure;import asunit.framework.TestListener;import asunit.errors.AssertionFailedError;import asunit.framework.TestMethod;class asunit.textui.XMLTestResult implements TestListener {		private var _duration:Number;	private var start:Number;	private var test:Test;	private var testName:String;	private var failureHash:Object;	private var failures:Array;	private var errorHash:Object;	private var errors:Array;	private var methodHash:Object;	private var methods:Array;		public function XMLTestResult(test:Test) {		this.test = test;		testName = test.getName().split("::").join(".");		failures = new Array();		errors = new Array();		methods = new Array();				failureHash = {};		errorHash = {};		methodHash = {};	}	public function startTest(test:Test):Void {		start = getTimer();	}		public function run(test:Test):Void {	}	public function addError(test:Test, t:Error):Void {		var failure:TestFailure = new TestFailure(test, t);		errors.push(failure);		errorHash[failure.failedMethod()] = failure;	}	public function addFailure(test:Test, t:AssertionFailedError):Void {		var failure:TestFailure = new TestFailure(test, t);		failures.push(failure);		failureHash[failure.failedMethod()] = failure;	}	public function startTestMethod(test:Test, methodName:String):Void {		var method:TestMethod = new TestMethod(test, methodName);		methods.push(method);		methodHash[method.getName()] = method;	}	public function endTestMethod(test:Test, methodName:String):Void {		methodHash[methodName].endTest(test);	}	public function endTest(test:Test):Void {		_duration = (getTimer() - start) * .001;	}		private function errorCount():Number {		return errors.length;	}		private function failureCount():Number {		return failures.length;	}		private function duration():Number {		return _duration;	}		private function renderSuiteOpener():String {		return "<testsuite name='" + testName + "' errors='" + errorCount() + "' failures='" + failureCount() + "' tests='" + methods.length + "' time='" + duration() + "'>\n";	}		private function renderTestOpener(methodName:String):String {		return "<testcase classname='" + testName + "' name='" + methodName + "' time='" + methodHash[methodName].duration() + "'>\n";	}		private function renderTestBody(method:String):String {		if(errorHash[method]) {			return renderError(errorHash[method]);		}		else if(failureHash[method]) {			return renderFailure(failureHash[method]);		}		else {			return "";		}	}		private function renderError(failure:TestFailure):String {		return "<error type='" + getQualifiedClassName(failure.thrownException()).split("::").join(".") + "'><![CDATA[\n" + failure.thrownException().toString() + "\n]]></error>\n";	}		private function renderFailure(failure:TestFailure):String {		return "<failure type='" + getQualifiedClassName(failure.thrownException()).split("::").join(".") + "'><![CDATA[\n" + failure.thrownException().toString() + "\n]]></failure>\n";	}		private function getQualifiedClassName(e:Object):String{		if(e.fqcn) return e.fqcn.toString();		return Error(e).name;	}	private function renderTestCloser():String {		return '</testcase>\n';	}		private function renderSuiteCloser():String {		return '</testsuite>\n';	}		public function toString():String {		var str:String = '';		str += renderSuiteOpener();		for(var name:String in methodHash) {			str += renderTestOpener(name);			str += renderTestBody(name);			str += renderTestCloser();		}		str += renderSuiteCloser();		return str;	}}