
class [%PACKAGE_NAME%].[%CLASS_NAME%] [%EXTENDS%]{
	public static var linkageId:String = "[%PACKAGES_PREFIX%][%PACKAGE_NAME%].[%CLASS_NAME%]";
	public static var classRef:Function = [%CLASS_NAME%];

	public function [%CLASS_NAME%]() {
	}
	
	public static var serializable:Boolean = Object.registerClass(linkageId, classRef);
}
