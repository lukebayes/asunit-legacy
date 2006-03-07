import asunit.framework.TestResult;

interface asunit.framework.Test {
	
	public function testsComplete():Boolean;
	public function setResult(result:TestResult):Void;
	public function setContext(context:MovieClip):Void;
	public function run():Void;
	public function countTestCases():Number;
	public function toString():String;
}