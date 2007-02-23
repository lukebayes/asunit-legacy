import asunit.errors.AssertionFailedError;
import asunit.errors.IllegalOperationError;

/**
 * Provides assert methods and other utility methods which are inherited by
 * the {@link TestCase} subclass. Since all user-defined test cases should
 * extend {@link TestCase} you should never have to use this class
 * directly.
 *
 * @see TestCase
 */
class asunit.framework.Assert {
	private static var defaultClassName:String = "[ClassName Unknown]";
	private static var lastDepth:Number = 10;

	private function Assert() {
	}
	
	/**
	 * Returns the next available depth for attaching a MovieClip.
	 *
	 * @return
	 *         Number of next available depth.
	 */
	public static function nextDepth():Number {
		return Assert.lastDepth++;
	}

	/**
	 * Appends a test result to the {@link TestRunner} which manages test
	 * result output. This method is intended for use by the AsUnit
	 * framework and should never have to be called directly.
	 *
	 * @param msg
	 *        The message associated with the assertion.
	 * @param assertType
	 *        The assertion type.
	 * @param passFail
	 *        Indicates whether the test passed (<code>true</code>) or
	 *        failed (<code>false</code>).
	 *
	 */
	public static function addTestResult(msg:String, assertType:String, passed:Boolean) {
		if(!passed) {
			var str:String = "";
			if(msg != "") {
				str += assertType + ".message: " + msg;
			}
			fail(str);
		}
	}

	/**
	 * Returns a reference to the {@link TestRunner} instance which manages
	 * the output of test results. This method is intended for use by the
	 * AsUnit framework and should never have to be called directly.
	private static function getTestRunner():TestRunner {
		if(testRunner == null) {
			testRunner = new TestRunner();
		}
		return testRunner;
	}
	 */

	/**
	 * Returns the number of {@link TestCases} that have completed.
	public static function countTestCases():Number {
		return testRunner.length;
	}
	 */

	/**
	 * Asserts that two objects are equal. If either of the
	 * objects provides an <code>equals()</code> method it will be used to
	 * determine equality. Otherwise, equality will be evaluated using the
	 * strict equality operator (<code>===</code>).<br />
	 * <br />
	 * The method below tests the <code>getFullName()</code> method of the
	 * <code>Person</code> class to make sure that the formatting of its
	 * return value is correct.<br />
	 *
	 * <pre>
	 * public function testGetFullName():Void {
	 *     var person:Person = new Person("John", "Alan", "Smith");
	 *     assertEquals("full name should be formatted: [first] [middleInitial]. [last]",
	 *                  "John A. Smith",
	 *                  person.getFullName());
	 * }
	 * </pre>
	 *
	 * @param msg
	 *        Optional; Message to display should the test fail. It is
	 *        recommended that this message describe what is asserted to be
	 *        true rather than describing what went wrong.
	 * @param assertion1
	 *        First object to use in evaluation.
	 * @param assertion2
	 *        Second object to use in evaluation.
	 */
	public static function assertEquals(msg:Object, assertion1:Object, assertion2:Object):Void {
		if(arguments.length == 2) {
			assertion2 = assertion1;
			assertion1 = msg;
			msg = "";
		}
		if(assertion1["equals"] instanceof Function) {
			addTestResult(String(msg), "assertEquals", assertion1["equals"](assertion2));
		} else if(assertion2["equals"] != undefined) {
			addTestResult(String(msg), "assertEquals", assertion2["equals"](assertion1));
		} else {
			addTestResult(format(String(msg), assertion1, assertion2), "assertEquals", assertion1 == assertion2);
		}

	}

	/**
	 * Asserts that a value is <code>null</code>.<br />
	 * <br />
	 * The method below tests to confirm that the parameter passed to the
	 * <code>getProductBySku</code> method of the
	 * <code>ProductCatalog</code> is treated as case sensitive.<br />
	 *
	 * <pre>
	 * public function testGetProductBySku():Void {
	 *     // Set up a fixture to test against.
	 *     var productCatalog:ProductCatalog = new ProductCatalog();
	 *     productCatalog.addProduct(new Product("sku123a"));
	 *
	 *     // Try retrieving a product using improper text case.
	 *     var product:Product = productCatalog.getProductBySku("SKU123A");
	 *     assertNull("the SKU parameter should be case sensitive",
	 *                product);
	 * }
	 * </pre>
	 *
	 * @param msg
	 *        Optional; Message to display should the test fail. It is
	 *        recommended that this message describe what is asserted to be
	 *        true rather than describing what went wrong.
	 * @param assertion
	 *        Object to be evaluated.
	 */
	public static function assertNull(msg:Object, assertion:Object):Void {
		if(arguments.length == 1) {
			assertion = msg;
			msg = "";
		}
		addTestResult(String(msg), "assertNull", (assertion === null));
	}

	/**
	 * Asserts that a value is not <code>null</code>.<br />
	 * <br />
	 * The method below tests to confirm that the parameter passed to the
	 * <code>getColorByName</code> method of the <code>ColorManager</code>
	 * class is treated as case insensitive.<br />
	 *
	 * <pre>
	 * public function testGetColorByName():Void {
	 *     // Set up a fixture to test against.
	 *     var colorManager:ColorManager = new ColorManager();
	 *     colorManager.addColor(new Color("blue"));
	 *
	 *     // Try retrieving a color using alternate text case.
	 *     var color:Color = colorManager.getColorByName("Blue");
	 *     assertNotNull("color name parameter should not be case sensitive",
	 *                   color);
	 * }
	 * </pre>
	 *
	 * @param msg
	 *        Optional; Message to display should the test fail. It is
	 *        recommended that this message describe what is asserted to be
	 *        true rather than describing what went wrong.
	 * @param assertion
	 *        Object to be evaluated.
	 */
	public static function assertNotNull(msg:Object, assertion:Object):Void {
		if(arguments.length == 1) {
			assertion = msg;
			msg = "";
		}
		addTestResult(String(msg), "assertNotNull", (assertion !== null));
	}

	/**
	 * Asserts that a value is <code>undefined</code>.
	 *
	 * @param msg
	 *        Optional; Message to display should the test fail. It is
	 *        recommended that this message describe what is asserted to be
	 *        true rather than describing what went wrong.
	 * @param assertion
	 *        Object to be evaluated.
	 */
	public static function assertUndefined(msg:Object, assertion:Object):Void {
		if(arguments.length == 1) {
			assertion = msg;
			msg = "";
		}
		addTestResult(String(msg), "assertUndefined", (assertion === undefined));
	}

	/**
	 * Asserts that a value is not <code>undefined</code>.
	 *
	 * @param msg
	 *        Optional; Message to display should the test fail. It is
	 *        recommended that this message describe what is asserted to be
	 *        true rather than describing what went wrong.
	 * @param assertion
	 *        Object to be evaluated.
	 */
	public static function assertNotUndefined(msg:Object, assertion:Object):Void {
		if(arguments.length == 1) {
			assertion = msg;
			msg = "";
		}
		addTestResult(String(msg), "assertNotUndefined", (assertion !== undefined));
	}

	/**
	 * Asserts that two variables are pointing to the same object in
	 * memory.<br />
	 * <br />
	 * The method below tests to confirm that the static
	 * <code>getInstance()</code> method of the <code>ServiceLocator</code>
	 * class always returns a reference to the same instance of
	 * <code>ServiceLocator</code>.<br />
	 *
	 * <pre>
	 * public function testGetInstance():Void {
	 *     var instance1:ServiceLocator = ServiceLocator.getInstance();
	 *     var instance2:ServiceLocator = ServiceLocator.getInstance();
	 *     assertSame("getInstance() should always return the same ServiceLocator instance",
	 *                instance1,
	 *                instance2);
	 * }
	 * </code>
	 *
	 * @param msg
	 *        Optional; Message to display should the test fail. It is
	 *        recommended that this message describe what is asserted to be
	 *        true rather than describing what went wrong.
	 * @param object1
	 *        First object to use in evaluation.
	 * @param object2
	 *        Second object to use in evaluation.
	 */
	public static function assertSame(msg:Object, object1:Object, object2:Object):Void {
		if(arguments.length == 2) {
			object2 = object1;
			object1 = msg;
			msg = "";
		}
		addTestResult(String(msg), "assertSame", (object1 === object2));
	}

	/**
	 * Asserts that a statement evaluates to <code>true</code>. Since this
	 * method lets you pass in any expression that evaluates to a boolean
	 * value, it is a good method to fall back on when the other
	 * <code>assert<i>XXX</i></code> methods don't provide the kind of
	 * functionality your test requires.<br />
	 * <br />
	 * The method below test to confirm that new <code>Product</code> objects
	 * are assigned ascending catalog numbers when created by the
	 * <code>ProductGenerator</code> class.<br />
	 *
	 * <pre>
	 * public function testMakeProductCatalogNumberAssignement():Void {
	 *     var generator:ProductGenerator = ProductGenerator.getInstance();
	 *     var product1:Product = generator.makeProduct("sku123");
	 *     var product2:Product = generator.makeProduct("sku456");
	 *     assertTrue("products should be assigned ascending catalog numbers",
	 *                product1.catNumber &lt; product2.catNumber);
	 * }
	 * </code>
	 *
	 * @param msg
	 *        Optional; Message to display should the test fail. It is
	 *        recommended that this message describe what is asserted to be
	 *        true rather than describing what went wrong.
	 * @param assertion
	 *        A statement that evaluates to a boolean value.
	 */
	public static function assertTrue(msg:Object, assertion:Boolean):Void {
		if(arguments.length == 1) {
			assertion = Boolean(msg);
			msg = "";
		}
		
		if(arguments.length > 2) {
			failError("Argument Count Exceeded " + String(msg), "assertTrue");
		}
		addTestResult(String(msg), "assertTrue", assertion);
	}

	/**
	 * Asserts that a statement evaluates to <code>false</code>. Since this
	 * method lets you pass in any expression that evaluates to a boolean
	 * value, it is a good method to fall back on when the other
	 * <code>assert<i>XXX</i></code> methods don't provide the kind of
	 * functionality your test requires.<br />
	 * <br />
	 * The method below tests to confirm that the return value of the
	 * <code>truncate()</code> method of the <code>TextUtil</code>
	 * class is no longer than the specified limit<br />
	 *
	 * <pre>
	 * public function testTruncate():Void {
	 *     var limit:Number = 30;
	 *     var text:String = "As a reviewer, I got an early opportunity to read the book you are holding.";
	 *     var clippedText:String = TextUtil.truncate(text, limit);
	 *     assertFalse("return value should be no more than 30 characters",
	 *                 clippedText.length &gt; 30);
	 * }
	 * </code>
	 *
	 * @param msg
	 *        Optional; Message to display should the test fail. It is
	 *        recommended that this message describe what is asserted to be
	 *        true rather than describing what went wrong.
	 * @param assertion
	 *        A statement that evaluates to a boolean value.
	 */
	public static function assertFalse(msg:Object, assertion:Boolean):Void {
		if(arguments.length == 1) {
			assertion = Boolean(msg);
			msg = "";
		}
		addTestResult(String(msg), "assertFalse", !assertion);
	}

	/**
	 * Forces a failing test result to be recorded. This method is useful
	 * in the rare circumstances where the <code>assert<i>XXX</i></code>
	 * methods can not be used, for example, when testing error
	 * handling.<br>
	 * <br />
	 * The method below tests to confirm that a "gifts" product category can
	 * be accessed through a <code>Catalog</code> instance.<br />
	 *
	 * <pre>
	 * public function testGiftsProductCategoryAccess():Void {
	 *     var catalog:ProductCatalog = CatalogFactory.getCatalog("fall2005");
	 *
	 *     // Try accessing the "gifts" product category.
	 *     try {
	 *         var products:Array = catalog.getProducts("gifts");
	 *     } catch (error:com.mycompany.errors.InvalidProductCategoryError) {
	 *         fail("catalog should contain 'gifts' products");
	 *     }
	 * }
	 * </pre>
	 */
	public static function fail(msg:String):Void {
		throw new AssertionFailedError(msg);
	}
	
//	private static function failNotEquals(message:String, expected:Object, actual:Object):Void {
//		fail(format(message, expected, actual));
//	}

	private static function format(message:String, expected:Object, actual:Object):String {
		var formatted:String = "";
		if(message != null) {
			formatted = message + " ";
		}
		return formatted + "expected:<" + expected + "> but was:<" + actual + ">";
	}
	
	public static function failError(msg:String):Void {
		throw new IllegalOperationError(msg);
	}
}