#include <windows.h>
#include <direct.h>
#include <stdlib.h>
#include <stdio.h>
#include <TChar.h>
#include "mm_jsapi.h" 


JSBool write(JSContext *cx, JSObject *obj,  unsigned int argc,   jsval *argv, jsval *rval)
{
	int pathLen;
	int nameLen;
	int contentLen;
	int i;
	unsigned short *pathStr;
	unsigned short *nameStr;
	unsigned short *contentStr;
  	JSBool open = JS_FALSE;
	char pathName[256];
	char content[1028];
 	FILE *file = NULL;
	char directoryName[256];
	boolean notFirstPass = 0;

	// Make sure the right number of arguments were passed in
	if (argc != 4){
		return JS_TRUE;
	}

	pathStr = JS_ValueToString(cx, argv[0], &pathLen);
	nameStr = JS_ValueToString(cx, argv[1], &nameLen);
	contentStr = JS_ValueToString(cx, argv[2], &contentLen);

	JS_ValueToBoolean(cx, argv[3], &open);

	// convert short to char
	wcstombs(pathName, pathStr, pathLen);

	pathName[pathLen] = 0;

	wcstombs(content, contentStr, contentLen);
	content[contentLen] = 0;

	// split path name into array of directory names

	// run through each char of pathName
	for(i = 0; i < 256; i++) {
		// when you hit "\\" 
		if(pathName[i] == '\\' && pathName[i + 1] == '\\') {
			if(notFirstPass) {
				// should probably check if dir exists first?  or will mkdir handle an existing folder?
				_mkdir(directoryName);
			}
			else {
				notFirstPass = 1;
			}
		}
		directoryName[i] = pathName[i];
		directoryName[i + 1] = 0;
	}




 	file = fopen(pathName, "w");

	if(file != NULL) {
		// write contents to file
 		fwrite(content, 1, contentLen, file);
		fclose(file);
		if(open == JS_TRUE) {
			ShellExecute(NULL, "open", pathName, NULL, NULL, 9);
		}
		*rval = JS_IntegerToValue(1);
		return JS_TRUE;
	}
	else{
		*rval = JS_IntegerToValue(0);
		return JS_TRUE;
	}
}


JSBool open(JSContext *cx, JSObject *obj,  unsigned int argc,   jsval *argv, jsval *rval)
{
	int pathLen;
	unsigned short *pathStr;
	char pathName[256];

	// Make sure the right number of arguments were passed in
	if (argc != 1){
		return JS_TRUE;
	}

	pathStr = JS_ValueToString(cx, argv[0], &pathLen);

	// convert short to char
	wcstombs(pathName, pathStr, pathLen);

	pathName[pathLen] = 0;

	ShellExecute(NULL, "open", pathName, NULL, NULL, 9);
	return JS_TRUE;
}


MM_STATE


void MM_Init()
{
	JS_DefineFunction(_T("write"),			write,			2);
	JS_DefineFunction(_T("open"),			open,			2);
}
	
