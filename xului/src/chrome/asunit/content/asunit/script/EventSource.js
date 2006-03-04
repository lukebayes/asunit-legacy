
var EventSource = function() {
}

EventSource.ALL = "all";
EventSource.prototype.listeners = new Array();

EventSource.prototype.addListener = function(listener) {
	var eventListener = new EventListener(listener, EventSource.ALL);
	this.removeListener(eventListener);
	this.listeners.push(eventListener);
}

EventSource.prototype.removeListener = function(listener) {
	var ln = this.listeners.length;
	for(var i = 0; i < ln; i++) {
		if(this.listeners[i].source == listener) {
			this.listeners.splice(i, 1);
			return;
		}
	}
}

EventSource.prototype.addEventListener = function(eventName, listener) {
	this.removeEventListener(eventName, listener);
	this.listeners.push(new EventListener(listener, eventName));
}

EventSource.prototype.removeEventListener = function(eventName, listener) {
	var ln = this.listeners.length;
	for(var i = 0; i < ln; i++) {
		if(this.listeners[i].source == listener &&
		   this.listeners[i].eventName == eventName) {
			this.listeners.splice(i, 1);
			return;
		}
	}
}

EventSource.prototype.broadcastEvent = function(event) {
	var ln = this.listeners.length;
	var func;
	for(var i = 0; i < ln; i++) {
		if(this.listeners[i].eventName == event.name ||
		   this.listeners[i].eventName == EventSource.ALL) {
		        func = this.listeners[i].source[event.name];
			if(func != null) {
			   	this.listeners[i].source[event.name](event);
			}
		}
	}
}
