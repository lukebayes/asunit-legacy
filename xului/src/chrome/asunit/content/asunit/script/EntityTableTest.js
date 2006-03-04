
var EntityTableTest = function() {
	this.run();
}

EntityTableTest.prototype = new TestCase();

EntityTableTest.prototype.instance;

EntityTableTest.prototype.setUp = function() {
	this.instance = EntityTable.create();
}

EntityTableTest.prototype.tearDown = function() {
	delete this.instance;
	EntityTable.destroy();
}

EntityTableTest.prototype.testInstantiated = function() {
	this.assertTrue("EntityTable instantiated", this.instance instanceof EntityTable);
}

var testCase = new EntityTableTest();

