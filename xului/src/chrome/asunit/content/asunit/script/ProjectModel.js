
var ProjectModel = function(view) {
	this.view = view
	this.addListener(this.view);
	this.projects = new Array();
}

ProjectModel.prototype = new EventSource();
ProjectModel.prototype.lastSelectedProject;
ProjectModel.prototype.view;
ProjectModel.prototype.incr = 1;
ProjectModel.prototype.projects;
ProjectModel.prototype.project;
ProjectModel.prototype.creatingProject = false;

ProjectModel.prototype.setCurrentProject = function(project) {
	if(project == undefined || project == null) {
		alert("ProjectModel.setCurrentProject called with undefined or NULL project");
		return false;
	}

	this.lastSelectedProject = this.project;
	this.project = project;
//	this.view.setModel(this.project);
	this.doOnSpecificChange("onProjectModelChanged", project);
	this.doOnSpecificChange("onCurrentProjectChanged", this.project);
	return true;
}

ProjectModel.prototype.getCurrentProject = function () {
	return this.project;
}

ProjectModel.prototype.setCurrentProjectById = function (id) {
	var ln = this.projects.length;
	for(var i = 0; i < ln; i++) {
		if(this.projects[i].projectId == id) {
			this.setCurrentProject(this.projects[i]);
		}
	}
}

ProjectModel.prototype.getProjectCount = function () {
	return this.projects.length;
}

ProjectModel.prototype.removeSelectedProject = function () {
	this.removeProject(this.project);
}

ProjectModel.prototype.removeProject = function(project) {
	try {
		var ln = this.projects.length;
		if(ln <= 1) {
			alert("You must always have at least one project");
			return false;
		}
		for(var i = 0; i < ln; i++) {
			if(this.projects[i].projectId == project.projectId) {
				this.projects.splice(i, 1);
				break;
			}
		}

		delete this.project;
		this.setCurrentProject(this.projects[Math.max(0, --i)]);
		return true;
	}
	catch(e) {
		alert("ProjectModel.removeProject: " + e);
	}
}

ProjectModel.prototype.addProject = function (project) {
	this.projects.push(project);
	this.view.rebuildProjectList(false);
}

ProjectModel.prototype.createNewProject = function () {
	try {
		this.creatingProject = true;
		var project = new ClassModel();
		this.addProject(project);
		this.setCurrentProject(project);
		this.view.showGettingStarted();
		this.doOnSpecificChange("onProjectModelChanged", project);
		this.creatingProject = false;
	}
	catch(e) {
		alert(">> ProjectModel.createNewProject ERROR: " + e.toString());
	}
}

ProjectModel.prototype.getProjects = function () {
	return this.projects;
}

ProjectModel.prototype.doOnSpecificChange = function(eventName, data) {
	var event = new Event();
	event.name = eventName;
	event.source = this;
	event.data = data;
	this.broadcastEvent(event);
}

ProjectModel.prototype.getUniqueProjectName = function(base) {
	return base + " " + (this.incr++);
}

ProjectModel.prototype.fromString = function(str) {
	if(str == "") {
		this.createNewProject();
		return;
	}
	if(str == null) {
		alert("fromString called with null string");
		return;
	}
	var projectList = str.split("\n");

	if(projectList.length == 0) {
		alert("fromString called with short string");
		return;
	}

	this.projects = new Array();
	var ln = projectList.length;
	for(var i = 0 ; i < ln; i++) {
		var project = new ClassModel();
		project.fromString(projectList[i]);
		this.projects.push(project);
	}

	this.setCurrentProject(this.projects[0]);
	this.doOnSpecificChange("onProjectModelChanged", project);
}

ProjectModel.prototype.toString = function() {
	var str = "";
//	var str += this.project.projectId + "\n";
	for(var k = 0; k < this.projects.length; k++) {
		str += this.projects[k].toString() + "\n";
	}
	return str;
}
