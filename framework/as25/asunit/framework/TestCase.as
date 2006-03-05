import asunit.framework.Assert;
import asunit.framework.Test;
import asunit.framework.TestResult;
import asunit.errors.AssertionFailedError;

class asunit.framework.TestCase extends Assert implements Test {
	private var className:String = "[default]";
	
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
	
	public function countTestCases():Number {
		return getTestMethods().length;
	}
	
	private function setUp():Void {
	}
	
	private function tearDown():Void {
	}
	
	private function cleanUp():Void {
	}
	
	public function setResult(result:TestResult):Void {
		this.result = result;
	}
	
	public function setContext(context:MovieClip):Void {
		this.context = context;
	}
	
	public function run():Void {
		var result:TestResult = getResult();
		result.run(this);
	}
	
	public function runBare():Void {
		var methods:Array = getTestMethods();
		var name:String;
		try {
			for(var i:Number = 0; i < methods.length; i++) {
				name = methods[i];
				try {
					runMethod(name);
				}
				catch(e:AssertionFailedError) {
					result.addFailure(this, e);
				}
				catch(ioe:Error) {
					result.addError(this, ioe);
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
		setUp();
		try {
			this[methodName]();
		}
		finally {
			if(!runSingle) {
				tearDown();
			}
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
	
	private function getResult():TestResult {
		return result;
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
		trace("TEST CASE TO STRING: " + getCurrentMethod());
		return getName() + "." + getCurrentMethod() + "()";
	}
	
	public function getName():String {
		return className;
	} 
}