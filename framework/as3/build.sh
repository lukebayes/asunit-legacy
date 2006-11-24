#! /bin/bash

rm -rf bin
mkdir bin

# First Compile the SWC File...

mxmlc -library-path 'bin/AsUnit.swc' -source-path '../../framework-test/as3' -debug -output 'bin/AsUnitTestRunner.swf' AsUnitTestRunner.as
