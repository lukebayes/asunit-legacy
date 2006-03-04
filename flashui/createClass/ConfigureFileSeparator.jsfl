
function ConfigureFileSeparator() {
	trace = fl.trace;
	if(fl.version.indexOf("MAC") > -1) {
		FLfile.separator = ":";
	} else {
		FLfile.separator = "\\";
	}
//	trace(">> File Separator is : " + FLfile.separator);
}
