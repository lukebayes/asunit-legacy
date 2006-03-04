package asunit.framework {
	import flash.display.DisplayObjectContainer;
		
	public interface Test {
		function countTestCases():int;
		function toString():String;
		function setResult(result:TestResult):void;
		function run():void;
		function getCurrentMethod():String;
		function getIsComplete():Boolean;
		function setContext(context:DisplayObjectContainer):void;
		function getContext():DisplayObjectContainer;
	}
}