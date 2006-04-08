/**
 * This file contains functionality that is shared by other ASUnit related jsfl-Files.
 *
 * @author Tibor Claassen (tibor@imagerator.com)
 * @version 1.0
 *
*/
 
 function getActiveDocumentURI() {
 
	var uri = fl.getDocumentDOM().path;
	if(uri == undefined) {
		fl.trace(">> Cannot determine path to current document on disk. Try saving first.");
		return false;
	}
		
	var isWin = (getPlatform() == "WIN") ? true : false;
	var isVersion7 = getVersion() < 8;
	
	if (isWin) uri = uri.split("\\");
	else if (isVersion7) uri = uri.split(":");
	else uri = uri.split("/");
	uri.pop();
	uri = uri.join("/") + "/";
	if (isWin) uri = "/" + uri.split(":").join("|");
	else if (isVersion7) uri = "/" + uri;
	uri = "file://" + uri;
	
	return uri;
 }
 
 function getPlatform() {
	return fl.version.substr(0, 3);
 }
 
 function getVersion() {
	return fl.version.charAt(4) * 1;
 }
 
 function getRevision() {
	var revision = fl.version.charAt(6) * 1;
	return getVersion() + revision / 10;
 }
 