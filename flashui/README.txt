
---------------------------------------
Flash QUICKSTART INSTRUCTIONS:
---------------------------------------

 - Open Flash MX Professional 2004
 - Create a new .fla file, name it "Example.fla" and save it to a NEW and EMPTY directory 
 	on your computer.
	*NOTE: There is deep recursive search and file creation associated with the 
	automated creation of Test Suites. This will cause undesired behavior if executed 
	outside of a project-only directory.
 - Open the Native Flash Output Panel if it's not already open (Window >> Development 
 	Panels >> Output or F2)
 - Click Window >> Other Panels >> AsUnit Ui
 - Dock the AsUnit Ui underneath (or above) the Output Panel
 * I try to save this panel set by choosing Window >> Save Panel Layout because sometimes
 	Flash will hide your panels for some crazy reason!
 - Choose Commands >> Create Class
 - In the pop-up window, type "com.asunit.example.ExampleClass" (without the quotes)
 - Select:
 	"Automatically Open New Files"
	"Add new Test
 	and be sure that "Prefix Class Name with __Packages" and "Add to Library as MovieClip"
is deselected.
	see: http://www.asunit.com/docs/img/simpleclass.jpg for an example.

 - Click OK
 - Select frame 1 of your new movie and open the Actions Panel (Window >> Development 
 	Panels >> Actions or F9)
 - In the Actions Panel, type:
	var at:AllTests = new AllTests();
 - Test the Movie (Control >> Test Movie or CTRL+ENTER)
 * Make sure that the Output Panel and Unit Test Panel both stay open. You can open the
 	Output Panel by pressing F2.

The Unit Test UI Panel should say something like, "1 of 2 Asserts Passed". This is
desired behavior because the new TestCase Template includes 2 assertions. The first one 
instantiates the newly-created class and asserts it's data type. This should be passing.

 * You should be able to click on the underlined portion of the Failing Test in the AsUnit Panel
 	To open the .as file directly.

The second assertion is a failing assertion that will provide immediate notification that
the newly-created TestCase is actually being executed.

 - Now go to com/asunit/example and open ExampleClassTest.as (From wherever you saved your
 	.FLA file.)
 - Change line 22 from:
	assertTrue("failingtest", false);
	to:
	assertTrue("passingtest", true);
 - Now Compile and you should have 2 of 2 Assertions passing.


---------------------------------------
NOTES:

 - If you EVER close the AsUnit UI Panel, you will probably have to click it's "RELOAD" 
 button.
 - If you EVER wonder if tests are being executed, click the Panel's "RELOAD" button.
 - You should *never* manually modify any file named "AllTests.as" as these are auto-created
 whenever you choose to "Create Class" with "Update Test Suites" selected OR when you choose
 the "Build Test Suites" command.
 - If you want your newly-created class to look differently, you can modify the Class Template 
 by opening: Configuration >> External Libraries >> ClassTemplate.as

* It should be fairly straightforward, anything found in [% %] will be replaced by your 
entries in the form, other than that everything will appear as expected.
* If you change this file, be sure to back it up and re-overwrite it whenever you update 
using the AsUnit.mxp file.

---------------------------------------
Flex QUICKSTART INSTRUCTIONS:
---------------------------------------

 - Download the SOURCE package (not just the installer)
 - Unzip the file into some directory and copy the entire contents of the "com" folder 
 	(including the "com" folder itself) into a folder that has been identified in the 
 	Flex classpath. Mine is as follows:
 	
 	File Found at: [Flex Installation Folder]/jrun4/servers/default/flex/WEB-INF/flex/flex-config.xml
 	
 	Approximately line 105
 	
        <actionscript-classpath>
	       	<!-- the build folder contains the "com" folder being copied -->
		<path-element>C:\Documents and Settings\lukebayes\My Documents\clients\asunit\build</path-element>
		<path-element>/WEB-INF/flex/user_classes</path-element>
        </actionscript-classpath>

 - Open the AsUnit Ui.swf file in the Flash Player or open this URL in a browser:
	http://www.asunit.com/AsUnitUi.swf
 - Click the "Show Sys.println" radio button so that it is selected.
 - Create a new line in your MXML file like the following:
 	Sys.println(">> Showing values from MXML");
 - Reload the MXML document in a browser window while keeping the AsUnit Ui open.
 - You should see text output in the AsUnit Ui panel.
 	* It's important for the panel to be open BEFORE the mxml is refreshed.
 	* It's important for the panel to be only one instance on your computer.
 
 - Create a new function in your MXML file that instantiates a new TestCase with the AsUnit Ui open.
 - Refresh the MXML page, you should see the Unit Test results reflected in the UI.
 - Check the Flex Documentation for how to instantiate a custom class
 - Check the AsUnit Article for what a TestCase looks like.
 - If you have trouble figuring out how to create a TestCase, use the Flash MX 2004 Professional
 	trial installation and read the other articles. There is more content and more Flex support
 	coming SOON!


---------------------------------------
TEST A LIBRARY MOVIECLIP INSTRUCTIONS:
---------------------------------------

 - Open the .FLA file that you created in the Quickstart or go through the Quickstart 
 	Instructions
 - Open your Library if it's not already open (Window >> Library)
 * You should see a set of folders nested as com/asunit/example/ with a MovieClip Symbol
 	named, ExampleClass.
 * These folders and the Symbol are created automatically by the CreateClass command and
 	are based on the fully-qualified class name that you have chosen.
 * The Create Class Command will *NOT* clobber an existing MovieClip OR ActionScript file
 	if you execute it more than once.
 - Click "Commands >> Create Class"
 * Note that the last-entered ClassName appears in the Text Field. This is saved into the 
 	.FLA file, so everyone that opens this file in the future will see the same thing.
 - Enter "com.asunit.example.ExampleMovie" (without the quotes) into the text field.
 - Select ONLY:
	"Automatically Open New Files"
	"Add to Library as MovieClip"
	"Add new Test
	and be sure that "Prefix Class Name with __Packages" is deselected.
	see: http://www.asunit.com/docs/img/extendsmovieclip-lib.jpg for an example
- Click OK
- Using your Library, double click the new MovieClip Symbol at: "com/asunit/example/ExampleMovie".
- Using the Drawing Tools, create a new Rectangle that has NO Stroke and is at:
	x:0
	y:0
	width:50
	height:50
- Save your .FLA file by pressing CTRL+S
- Execute Test Movie.
- You should have 3 of 4 Asserts Passing.
 * You should be able to click on the underlined portion of the Failing Test in the AsUnit Panel
 	To open the .as file directly.
- Open com/asunit/example/ExampleMovieTest.as
- Notice how the "setUp" method is not creating a MovieClip instance using attachMovie, but
	is instead simply instantiating it as an Object.
 - Update the Test Case so that the setUp and tearDown methods look like the following:
 
        public function setUp():Void {
                var initObj:Object = new Object();
                initObj._width = 200;
                instance = ExampleMovie(attachMovie(ExampleMovie.linkageId, initObj));
       }
 

- Now Comment out the entire "tearDown" method and run Test Movie.
- You should see a Rectangle on stage that is 200 pixels wide by 50 pixels tall.
- Now replace the "test" method with the following code:

	public function testWidth():Void {
		assertTrue("width should be 200", instance._width == 200);
	}

- Running Test Movie at this time, should throw a compile error because your Class definition
	Does not Extend MovieClip and therefore does not have a "_width" method defined.
- Open ExampleMovie.as and update the class definition as follows:

	class ExampleMovie extends MovieClip {

- Run Test Movie again and you should find 4 of 4 Asserts Passing. 


---------------------------------------
TEST A NON-LIBRARY MOVIECLIP INSTRUCTIONS:
---------------------------------------

 - Open the .FLA file that you created in the Quickstart or go through the Quickstart 
 	Instructions
 - Open your Library if it's not already open (Window >> Library)
  * You should see a set of folders nested as com/asunit/example/ with a MovieClip Symbol
  	named, ExampleClass.
  * These folders and the Symbol are created automatically by the CreateClass command and
  	are based on the fully-qualified class name that you have chosen.
  * The Create Class Command will *NOT* clobber an existing MovieClip OR ActionScript file
 	if you execute it more than once.
 - Click "Commands >> Create Class"
 - Select ONLY:
	"Automatically Open New Files"
	"Prefix Class Name with Packages"
	"Add new Test
	and be sure that "Add to Library as MovieClip" is deselected.
	see: http://www.asunit.com/docs/img/extendsmovieclip-nonlib.jpg for an example.
 - Click OK
 - Open com/asunit/example/ExampleClipTest.as
 
 
 - Update the Test Case so that the setUp and tearDown methods look like the following:
 
 	public function setUp():Void {
 		var initObj:Object = new Object();
 		initObj._xscale = 200;
 		instance = ExampleClip(attachMovie(ExampleClip.linkageId, initObj));
 	}
 
 	public function tearDown():Void {
 		instance.removeMovieClip();
 	}
 
 - Open com/asunit/example/ExampleClip.as and note the linkageId has "__Packages" prefix.
 * This will register the Class Definition as a MovieClip without anything in your Library.
 - Run TestMovie
 - You should have 3 of 4 Asserts Passed.
 * You should be able to click on the underlined portion of the Failing Test in the AsUnit Panel
 	To open the .as file directly.
 - Update the "test" method of the TestCase (ExampleClipTest.as) to look like:
 
 	public function testXscale():Void {
 		assertTrue("_xscale should be 200", instance._xscale == 200);
	}
 
 - Run TestMovie
 - You should have 4 of 4 Asserts Passing.
 * NOTE That we couldn't update the _width property because the clip is empty and the _width 
 	won't be adjusted.


 
