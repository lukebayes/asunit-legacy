
import com.asunit.framework.*;
import com.asunit.util.*;

class com.asunit.framework.TestRunner extends Array {
	public static var localConn:LocalConnClient;
	private var intervalId:Number;
	private var interval:Number = 10;
	private var tests:Array;

	public static function getLocalConn():LocalConnClient {
		if(localConn == null) {
			localConn = LocalConnGateway.createClient("_AsUnitTestRunner");
			localConn["clearTestDisplay"]();
		}
		return localConn;
	}

	public static function addSuccess(ref:TestResult):Void {
		var lc:LocalConnClient = getLocalConn();
		lc["addSuccess"](ref);
	}

	public static function addFailure(ref:TestFailure):Void {
		var lc:LocalConnClient = getLocalConn();
		lc["addFailure"](ref);
	}

	public function TestRunner() {
		tests = new Array();
	}

	public function push(item:Object):Number {
		var num:Number = tests.push(item);
		clearInterval(intervalId);

		if(num > 100) {
			renderTests(tests);
		} else {
			intervalId = setInterval(this, "renderTests", interval, tests);
		}
		return num;
	}

	public function renderTests(arr:Array):Void {
		clearInterval(intervalId);
		var lc:LocalConnClient = getLocalConn();
		lc["addTests"](arr);
		tests = new Array();
	}
}
