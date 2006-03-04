#!/bin/bash
# build.sh: build JAR and XPI files from source
# based on Nathan Yergler's build script
# Modified to work on OS X by Mike Chambers (http://mesh.typepad.com)

#### editable items (none of these can be blank)
APP_NAME=AsUnit      # short-name, jar and xpi files name.
JAR_NAME=AsUnit	     # Name for internal jar packages
HAS_DEFAULTS=1       # whether the ext. provides default values for user prefs etc.
HAS_COMPONENTS=0     # whether the ext. includes any components
HAS_LOCALE=1         # package APP_NAME.jar/locale/ ?
HAS_SKIN=0           # package APP_NAME.jar/skin/ ?
KEEP_JAR=1           # leave the jar when done?
ROOT_FILES="license.txt install.rdf install.js application.ini" # put these files in root of xpi
INSTALLED_DIR="/home/lbayes/shortcuts/appdata/Mozilla/Firefox/Profiles/x0xvmhns.default/extensions/{6FF5DFB2-2612-4b41-9939-B640BA5D90AF}/chrome"
PUT_FIREFOX=0	     # debugging util to automatically replace jars in firefox
LAUNCH_XULRUNNER=1   # debugging util to auto-open in xulrunner
#### editable items end

TMP_DIR=build.tmp

#uncomment to debug
#set -x

# remove any left-over files
rm $APP_NAME.jar
rm $APP_NAME.xpi
rm -rf $TMP_DIR

# create xpi directory layout and populate it
mkdir $TMP_DIR
mkdir $TMP_DIR/chrome
cp -R chrome/* $TMP_DIR/chrome/

if [ $HAS_COMPONENTS = 1 ]; then
  mkdir $TMP_DIR/components
  cp components/* $TMP_DIR/components
fi

if [ $HAS_DEFAULTS = 1 ]; then
  DEFAULT_FILES="`find ./defaults -path '*DS_Store*' -prune -o -type f -print | grep -v \~`"
  cp --parents $DEFAULT_FILES $TMP_DIR
fi

# Copy other files to the root of future XPI.
cp $ROOT_FILES $TMP_DIR

#REMOVE SVN FILES from build...
cd $TMP_DIR
find -type d -name .svn |
	while read file
	do
		echo $file
		rm -rf $file
	done
cd ..


# generate the JAR file, excluding .DS_Store and temporary files
cd $TMP_DIR/chrome/$JAR_NAME
zip -r ../$APP_NAME.jar *
cd ../

if [ $HAS_LOCALE = 1 ]; then
	cd en-US/
	zip -r ../en-US.jar *
	cd ../
	rm -rf en-US
fi

cp en-US.jar ../../chrome/
rm -rf $APP_NAME
cd ../../
echo =============================
#echo $INSTALLED_DIR
if [ $PUT_FIREFOX = 1 ]; then

	rm $INSTALLED_DIR/Asunit.jar
	rm $INSTALLED_DIR/en-US.jar
	rm $INSTALLED_DIR/chrome.manifest

	cp chrome/AsUnit.jar $INSTALLED_DIR/
	cp chrome/en-US.jar $INSTALLED_DIR/
	cp chrome/chrome.manifest $INSTALLED_DIR/
fi
echo =============================


if [ $KEEP_JAR = 1 ]; then
	cp $TMP_DIR/chrome/$JAR_NAME.jar chrome/
fi

#if [ $HAS_LOCALE = 1 ]; then
#	zip -0 -r $TMP_DIR/chrome/$APP_NAME.jar `find locale -path '*DS_Store*' -prune -o -type f -print | grep -v \~`
#fi

#if [ $HAS_SKIN = 1 ]; then
#	zip -0 -r $TMP_DIR/chrome/$APP_NAME.jar `find skin -path '*DS_Store*' -prune -o -type f -print | grep -v \~`
#fi

# generate the XPI file
cd $TMP_DIR
zip -r ../$APP_NAME.xpi *
cd ..

# remove the working files
rm -rf $TMP_DIR

rm -rf ../bin/AsUnit.xpi

mv $APP_NAME.xpi ../bin/$APP_NAME.xpi

if [ $LAUNCH_XULRUNNER = 1 ]; then
	xulrunner application.ini
fi

if [ $PUT_FIREFOX = 1 ]; then
	firefox -chrome chrome://asunit/content/AsUnit.xul
fi