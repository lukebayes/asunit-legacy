
class [%PACKAGE_NAME%]AllTests extends com.asunit.framework.TestSuite {
	private var className:String = "[%PACKAGE_NAME%]AllTests";

	public function AllTests() {
		super();
		[%TEST_LIST%]}
}
