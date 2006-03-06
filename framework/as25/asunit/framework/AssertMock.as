import asunit.framework.Assert;

class asunit.framework.AssertMock extends Assert {
	
	public function AssertMock() {
	}
	
	public function assertTrue():Void {
		Assert.assertTrue.apply(Assert, arguments);
	}
	
	public function assertEquals():Void {
		Assert.assertEquals.apply(arguments);
	}
}