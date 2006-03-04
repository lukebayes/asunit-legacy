
var AsFileTest = function() {
	this.run();
}

AsFileTest.prototype = new TestCase();

AsFileTest.prototype.filePath = "C:\\cygwin\\bin";
AsFileTest.prototype.instance;

AsFileTest.prototype.setUp = function() {
	this.instance = new AsFile();
}

AsFileTest.prototype.tearDown = function() {
	delete this.instance;
}

AsFileTest.prototype.testInstantiated = function() {
	this.assertTrue("EntityTable instantiated", this.instance instanceof AsFile);
}

AsFileTest.prototype.testOpen = function() {
	try {
		this.instance.open(this.filePath);
		this.assertTrue("AsFileTest.openned file is a directory", this.instance.isDirectory());
	} catch(e) {
		alert(e.toString());
	}
}

var testCase = new AsFileTest();

