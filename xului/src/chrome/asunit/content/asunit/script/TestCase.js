
var TestCase = function() {
}

TestCase.prototype = new Object();

TestCase.prototype.run = function() {
	for(var i in this) {
		if(i.indexOf("test") == 0) {
			this.setUp();
			this[i]();
			this.tearDown();
		}
	}
}

TestCase.prototype.setUp = function() {
}

TestCase.prototype.tearDown = function() {
}

TestCase.prototype.assertTrue = function(msg, assertion) {
	if(!assertion) {
		alert("assertTrue failed with: " + msg);
	}
}
