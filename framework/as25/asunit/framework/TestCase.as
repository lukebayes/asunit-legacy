import asunit.framework.Assert;
import asunit.framework.Test;
import asunit.framework.TestResult;
import asunit.errors.AssertionFailedError;
import asunit.errors.AssertionPassedError;

class asunit.framework.TestCase extends Assert implements Test {
	private var className:String = "[default]";

	private var testMethodsExecuted:Number = 0;
	private var result:TestResult;
	private var context:MovieClip;
	private var currentMethod:String;
	private var runSingle:Boolean;
	private var isComplete:Boolean;

	public function TestCase(testMethod:String) {
		if(testMethod != undefined) {
			runSingle = true;
			currentMethod = testMethod;
		}
	}

	/*
	 * You can choose to override this method when implementing
	 * asynchronous test cases.
	 * By default, the TestCaseXml object will call back to this
	 * method and begin execution of the test case.
	 */
	public function onXmlLoaded(node:XMLNode):Void {
		runNow();
	}

	/*
	 * By default, this method will be triggered from
	 * a TestCaseXml instance. If there is a problem
	 * an error will be shown in the output.
	 */
	public function onXmlFailure(node:XML):Void {
		currentMethod = "onXmlFailure";
		getResult().addError(this, new Error("TestCaseXml failed to load successfully: " + node.toString()));
		runNow();
	}

	public function testsComplete():Boolean {
		return (getTestMethods().length == testMethodsExecuted);
	}

	public function countTestCases():Number {
		return getTestMethods().length;
	}

	/*
	 * setUp() is called before each method that begins with "test*"
	 * This method should used to instantiate common fixtures
	 */
	private function setUp():Void {
	}

	/*
	 * tearDown() is called after each method that begins with "test*"
	 * This method should be used to destroy any objects created from
	 * the setUp() method call
	 */
	private function tearDown():Void {
	}

	/* cleanUp() is called one time after all test methods have completed
	 * in a single TestCase. This is typically overridden and used to
	 * clean up after an Asynchronous TestCase has completed.
	 */
	private function cleanUp():Void {
	}

	public function setResult(result:TestResult):Void {
		this.result = result;
	}

	private function getResult():TestResult {
		return result;
	}

	public function setContext(context:MovieClip):Void {
		this.context = context;
	}

	public function getContext():MovieClip {
		return context;
	}

	public function run():Void {
		runNow();
	}

	private function runNow():Void {
		var result:TestResult = getResult();
		result.run(this);
	}

	public function runBare():Void {
		var methods:Array = getTestMethods();
		var name:String;
		try {
			var len:Number = methods.length;
			for(var i:Number = 0; i < len; i++) {
				name = methods[i];
				try {
					runMethod(name);
				}
				catch(e:Error) {
					if(e instanceof AssertionFailedError) {
						result.addFailure(this, AssertionFailedError(e));
					}
					else if(!(e instanceof AssertionPassedError)) {
						result.addError(this, e);
					}
				}
			}
		}
		finally {
			if(!runSingle) {
				cleanUp();
			}
		}

		isComplete = true;
	}

	private function runMethod(methodName:String):Void {
		currentMethod = methodName;
		try {
			setUp();
			this[methodName]();
		}
		finally {
			if(!runSingle) {
				tearDown();
			}
			testMethodsExecuted++;
		}
	}

	private function getTestMethods():Array {
		if(runSingle) {
			return new Array(currentMethod);
		}
		var methods:Array = new Array();
		_global.ASSetPropFlags(this.__proto__, null, 6, true);
		for(var i:String in this) {
			if(i.indexOf("test") == 0 && this[i] instanceof Function) {
				methods.push(i);
			}
		}
		_global.ASSetPropFlags(this.__proto__, null, 1, true);
		methods.reverse();
		return methods;
	}

	/**
	 * Returns the name of the currently running test method. This
	 * method is intended for use by the AsUnit framework and should never
	 * have to be called directly.
	 *
	 * @return
	 *        A method name. Ex. <code>"testGetValue"</code>.
	 */
	public function getCurrentMethod():String {
		return currentMethod;
	}

	public function toString():String {
		return getName() + "." + getCurrentMethod() + "()";
	}

	public function getName():String {
		return className;
	}

	private function createEmptyMovieClip(name:String, depth:Number):MovieClip {
		return getContext().createEmptyMovieClip(name, depth);
	}

	private function createTextField(name:String, depth:Number, x:Number, y:Number, width:Number, height:Number):TextField {
	    getContext().createTextField(name, depth, x, y, width, height);
	    return TextField(getContext()[name]);
	}

	private function getNextHighestDepth():Number {
		return getContext().getNextHighestDepth();
	}

	/*
	 * This helper method will support the following method signatures:
	 *
	 * attachMovie(linkageId:String):MovieClip;
	 * attachMovie(linkageId:String, initObject:Object):MovieClip;
	 * attachMovie(linkageId:String, name:String, depth:Number):MovieClip;
	 * attachMovie(linkageId:String, name:String, depth:Number, initObject:Object):MovieClip;
	 *
	 * @return
	 * 	MovieClip
	 */
 	private function attachMovie():MovieClip {
 		var linkageId:String = arguments[0];
 		var name:String;
 		var depth:Number;
 		var initObj:Object = new Object();

		switch(arguments.length) {
			case 1 :
			case 2 :
			name = getValidName(getContext(), name);
			depth = getValidDepth(getContext());
 			initObj = arguments[1];
 			break;
 			case 3 :
 			case 4 :
 			name = arguments[1];
 			depth = arguments[2];
 			initObj = arguments[3];
 			break;
		}
		return getContext().attachMovie(linkageId, name, depth, initObj);
 	}

	public function getUpperEmptyDepth(parent:MovieClip, depth:Number):Number {
		if(depth == undefined || !isValidDepth(parent, depth)) {
			var high:Number = (depth == undefined) ? 1 : depth;
			for(var i:String in parent) {
				if(parent[i] instanceof MovieClip && parent[i].getDepth() != undefined) {
					high = Math.max(parent[i].getDepth()+1, high);
				}
			}
			return high;
		}
		return depth;
	}

	private function getValidName(parent:MovieClip, nm:Object):String {
		var incr:Number = 1;

		var name:String = (nm == undefined || nm instanceof Object) ? "item" : nm.toString();
		var ref:MovieClip = parent[name];

		var name2:String = name;
		while(ref != undefined && incr < 100) {
			name2 = name + "-" + (incr++);
			ref = parent[name2];
		}
		return name2;
	}

	private function isValidDepth(parent:MovieClip, depth:Number):Boolean {
		var item:MovieClip = getItemByDepth(parent, depth);
		return (item == null) ? true : false;
	}

	private function getItemByDepth(parent:MovieClip, depth:Number):MovieClip {
		for(var i:String in parent) {
			if(parent[i].getDepth() == depth) {
				return parent[i];
			}
		}
		return null;
	}

	private function getValidDepth(mc:MovieClip):Number {
		var mcDepth:Number;
		var dp:Number = nextDepth();
		for(var i:String in mc) {
			mcDepth = mc[i].getDepth();
			if(mc[i] instanceof MovieClip && mcDepth < 10000) {
				dp = Math.max(mcDepth, dp);
			}
		}
		return ++dp;
	}
}