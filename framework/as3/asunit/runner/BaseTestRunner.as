package asunit.runner {
	import asunit.errors.AbstractMemberCalledError;
	import asunit.errors.AssertionFailedError;
	import asunit.errors.ClassNotFoundError;
	import asunit.errors.InvocationTargetError;
	import asunit.errors.UnimplementedFeatureError;
	import asunit.framework.Test;
	import asunit.framework.TestListener;
	import asunit.framework.TestSuite;
	import asunit.util.Properties;
	
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	/**
	 * Base class for all test runners.
	 * This class was born live on stage in Sardinia during XP2000.
	 */
	public class BaseTestRunner extends Sprite {
//	public class BaseTestRunner extends Sprite implements TestListener {
/*
 		public static const SUITE_METHODNAME:String = "suite";
	    public static const STATUS_ERROR:int = 1;
	    public static const STATUS_FAILURE:int = 2;	
		private static var fPreferences:Properties;
		protected static var fgMaxMessageLength:int = 500;
		protected static var fgFilterStack:Boolean = true;

		protected var fLoading:Boolean = true;
		private var abstractClassName:String = "asunit.runner::BaseTestRunner";

		public function BaseTestRunner() {
//			if(describeType(this).@name == abstractClassName) {
//				throw new AbstractMemberCalledError("BaseTestRunner.constructor");
//			}
		}

	    // Implementation of TestListener

		public function startTest(test:Test):void {
			testStarted(test.toString());
		}
	
		protected static function setPreferences(preferences:Properties):void {
			fPreferences = preferences;
		}
	
		protected static function getPreferences():Properties {
			if (fPreferences == null) {
				fPreferences = new Properties();
		 		fPreferences.put("loading", "true");
	 			fPreferences.put("filterstack", "true");
			}
			return fPreferences;
		}
	
	 	private static function readPreferences():void {
			throw new UnimplementedFeatureError("BaseTestRunner.readPreferences");
//	 		var is:InputStream = null;
//	 		try {
//	 			is = new FileInputStream(getPreferencesFile());
//	 			setPreferences(new Properties(getPreferences()));
//				getPreferences().load(is);
//			} catch (IOException e) {
//				try {
//					if (is != null)
//						is.close();
//				} catch (IOException e1) {
//				}
//			}
	 	}
	
		//  throws IOException 
		public static function savePreferences():void {
			throw new UnimplementedFeatureError("BaseTestRunner.savePreferences");
//			FileOutputStream fos = new FileOutputStream(getPreferencesFile());
//			try {
//				getPreferences().store(fos, "");
//			} finally {
//				fos.close();
//			}
		}
	
		public function setPreference(key:String, value:String):void {
			getPreferences().setProperty(key, value);
		}
	
		public function endTest(test:Test):void {
			testEnded(test.toString());
		}
	
		public function addError(test:Test, t:Error):void {
			testFailed(BaseTestRunner.STATUS_ERROR, test, t);
		}
	
		public function addFailure(test:Test, t:AssertionFailedError):void {
			testFailed(BaseTestRunner.STATUS_FAILURE, test, t);
		}
	
		// TestRunListener implementation
		// BEGIN ABSTRACT METHODS
		public function testStarted(testName:String):void {
			throw new AbstractMemberCalledError("BaseTestRunner.testStarted");
		}

		public function testEnded(testName:String):void {
			throw new AbstractMemberCalledError("BaseTestRunner.testEnded");
		}

		public function testFailed(status:int, test:Test, t:Error):void {
			throw new AbstractMemberCalledError("BaseTestRunner.testFailed");
		}
		
		// Override to define how to handle a failed loading of
		// a test suite.
		protected function runFailed(message:String):void {
			throw new AbstractMemberCalledError("BaseTestRunner.runFailed");
		}
	
		// Returns the Test corresponding to the given suite. This is
		// a template method, subclasses override runFailed(), clearStatus().
		public function getTest(testCase:Class):Test {
			return null;

			!!!!!!!!!!CHANGEED testCase from String to CLASS - not implemented yet
			if (suiteClassName.length <= 0) {
				clearStatus();
				return null;
			}
			var TestClass:Class = null;
			
			try {
				TestClass = getDefinitionByName(testCase);
			}
			catch(e:ClassNotFoundError) {
				var clazz:String = e.getMessage();
				if (clazz == null) {
					clazz = suiteClassName;
				}
				runFailed("Class not found \"" + clazz + "\"");
				return null;
			} catch(e:Error) {
				runFailed("Error: " + e.toString());
				return null;
			}

			var testInstance:Test = null;
			try {
				testInstance = new TestClass();
		 	} catch(e:Error) {
		 		// try to extract a test suite automatically
				//clearStatus();
				//return new TestSuite(TestClass);
				return null;
			}
			*/

/*
			try {
				testClass = loadSuiteClass(suiteClassName);
			} catch (e:ClassNotFoundError) {
				var clazz:String = e.getMessage();
				if (clazz == null) {
					clazz = suiteClassName;
				}
				runFailed("Class not found \"" + clazz + "\"");
				return null;
			} catch(e:Error) {
				runFailed("Error: " + e.toString());
				return null;
			}
			var suiteMethod:Function = null;
			try {
				suiteMethod = testClass.getMethod(SUITE_METHODNAME, new Class[0]);
		 	} catch(e:Error) {
		 		// try to extract a test suite automatically
				clearStatus();
				return new TestSuite(testClass);
			}
//			if (! Modifier.isStatic(suiteMethod.getModifiers())) {
//				runFailed("Suite() method must be static");
//				return null;
//			}
			var test:Test = null;
			try {
				test = Test(suiteMethod.invoke(null, new Class[0])); // static method
				if (test == null) {
					return test;
				}
			}
			catch (e:InvocationTargetError) {
				runFailed("Failed to invoke suite():" + e.getTargetException().toString());
				return null;
			}
			catch (e:IllegalOperationError) {
				runFailed("Failed to invoke suite():" + e.toString());
				return null;
			}
			clearStatus();
			return test;
		}

		// Returns the formatted string of the elapsed time.
		public function elapsedTimeAsString(runTime:Number):String {
			return runTime.toString();
//			return NumberFormat.getInstance().format(Number(runTime/1000));
		}
	
		// Processes the command line arguments and
		// returns the name of the suite class to run or null
		protected function processArguments(args:Array):String {
			var suiteName:String = null;
			for (var i:int; i < args.length; i++) {
				if (args[i] == "-noloading") {
					setLoading(false);
				} else if (args[i] == "-nofilterstack") {
					fgFilterStack= false;
				} else if (args[i] == "-c") {
					if (args.length > i+1) {
						suiteName = extractClassName(args[i+1]);
					}
					else {
						trace("Missing Test class name");
					}
					i++;
				} else {
					suiteName = args[i];
				}
			}
			return suiteName;
		}
	
		// Sets the loading behaviour of the test runner
		public function setLoading(enable:Boolean):void {
			fLoading = enable;
		}

		// Extract the class name from a String in VA/Java style
		public function extractClassName(className:String):String {
			if(className.indexOf("Default package for") == 0) {
				return className.substring(className.lastIndexOf(".") + 1);
			}
			return className;
		}
	
		// Truncates a String to the maximum length.
		public static function truncate(s:String):String {
			if (fgMaxMessageLength != -1 && s.length > fgMaxMessageLength)
				s = s.substring(0, fgMaxMessageLength) + "...";
			return s;
		}

		// Returns the loaded Class for a suite name.
		// throws ClassNotFoundException
		protected function loadSuiteClass(suiteClassName:String):Class {
			return getLoader().load(suiteClassName);
		}
	
		// Clears the status message.
		protected function clearStatus():void { // Belongs in the GUI TestRunner class
			throw new AbstractMemberCalledError("BaseTestRunner.clearStatus");
		}
	
		// Returns the loader to be used.
		public function getLoader():TestSuiteLoader {
			throw new UnimplementedFeatureError("BaseTestRunner.getLoader");
//			if (useReloadingTestSuiteLoader())
//				return new ReloadingTestSuiteLoader();
//			return new StandardTestSuiteLoader();
		}
	
		protected function useReloadingTestSuiteLoader():Boolean {
			return false;
//			return getPreference("loading").equals("true") && !inVAJava() && fLoading;
		}
	
		// Should return File...
		private static function getPreferencesFile():Object {
			throw new UnimplementedFeatureError("BaseTestRunner.getPreferencesFile");
//		 	var home:String = System.getProperty("user.home");
//	 		return new File(home, "junit.properties");
	 	}
	
	 	public static function getPreference(key:String):String {
	 		return getPreferences().getProperty(key);
	 	}
	
//	 	public static function inVAJava():Boolean {
//			try {
//				Class.forName("com.ibm.uvm.tools.DebugSupport");
//			}
//			catch (e:Error) {
//				return false;
//			}
//			return true;
//		}
	
		// Returns a filtered stack trace
		public static function getFilteredTrace(t:Error):String {
			throw new UnimplementedFeatureError("BaseTestRunner.getFilteredTrace");
			var stringWriter:StringWriter = new StringWriter();
			var writer:PrintWriter = new PrintWriter(stringWriter);
			t.printStackTrace(writer);
			var buffer:StringBuffer = stringWriter.getBuffer();
			var trace:String = buffer.toString();
			return BaseTestRunner.getFilteredTrace(trace);
		}
*/	
		// Filters stack frames from internal JUnit classes
		public static function getFilteredTrace(stack:String):String {
			return stack;
			
			//throw new UnimplementedFeatureError("BaseTestRunner.getFilteredTrace");
//			if (showStackRaw()) {
//				return stack;
//			}
//	
//			var sw:StringWriter = new StringWriter();
//			var pw:PrintWriter = new PrintWriter(sw);
//			var sr:StringReader = new StringReader(stack);
//			var br:BufferedReader = new BufferedReader(sr);
//			var line:String;
//			try {
//				while ((line = br.readLine()) != null) {
//					if (!filterLine(line))
//						pw.println(line);
//				}
//			} catch (Exception IOException) {
//				return stack; // return the stack unfiltered
//			}
//			return sw.toString();
		}
/*	
		protected static function showStackRaw():Boolean {
			return !getPreference("filterstack") == true || fgFilterStack == false;
		}
	
		protected static function filterLine(line:String):Boolean {
			var patterns:Array = new Array();
			patterns.push("junit.framework.TestCase");
			patterns.push("junit.framework.TestResult");
			patterns.push("junit.framework.TestSuite");
			patterns.push("junit.framework.Assert."); // don't filter AssertionFailure
			patterns.push("junit.swingui.TestRunner");
			patterns.push("junit.awtui.TestRunner");
			patterns.push("junit.textui.TestRunner");
			patterns.push("java.lang.reflect.Method.invoke(");
			
			for(var i:uint; i < patterns.length; i++) {
				if (line.indexOf(patterns[i]) > 0) {
					return true;
				}
			}
			return false;
		}
 */
	}
 }
