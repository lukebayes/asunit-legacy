import asunit.runner.IResultPrinter;
import asunit.errors.AssertionFailedError;
import asunit.framework.Test;
import asunit.framework.TestResult;
import asunit.framework.TestFailure;
import asunit.runner.BaseTestRunner;
import asunit.textui.SuccessBar;
import asunit.framework.ITestListener;

class asunit.textui.ResultPrinter extends MovieClip implements IResultPrinter, ITestListener {
	public static var linkageId:String = "__Packages.asunit.textui.ResultPrinter";
	public static var classRef:Function = ResultPrinter;
	private static var instance:ResultPrinter;
	
	private var fColumn:Number = 0;
	private var showTrace:Boolean;
	private var barHeight:Number = 3;
	private var bgColor:Number = 0x333333;
	private var fontColor:Number = 0xFFFFFF;
	private var spacing:Number = 5;
	private var textArea:TextField;
	private var traceOutput:TextField;
	private var successMeter:MovieClip;
	private var bar:SuccessBar;
	
	public function ResultPrinter() {
		init();
		configureAssets();
		println("AsUnit 2.5 by Luke Bayes and Ali Mills");
		// If you can't see clips that you think should be
		// attached... Perhaps it's behind this runner?
		//_alpha = 50;
	}
	
	private function init():Void {
		if(instance != undefined) {
			throw new Error("Resultprinter instantiated twice in one session, this will likely cause problems");
		}
		instance = this;
		Stage.addListener(this);
	}
	
	private function onLoad():Void {
		onResize();
	}
	
	private function configureAssets():Void {
		createTextArea();
		createOutput();
		createSuccessBar();
	}
	
	public function traceln():Void {
		traceOutput._visible = true;
		traceOutput.text += arguments.toString() + "\n";
		traceOutput.scroll = traceOutput.maxscroll;
	}
	
	public function println():Void {
		textArea.text += arguments.toString() + "\n";
	}
	
	public function printf():Void {
		textArea.text += arguments.toString();
	}

	public function startTest(test:Test):Void {
		var count:Number = test.countTestCases();
		for(var i:Number = 0; i < count; i++) {
			printf(".");
			if (fColumn++ >= 80) {
				println();
				fColumn = 0;
			}
		}
	}
	
	public function addError(test:Test, e:Error):Void {
		printf("E");
	}
	
	public function addFailure(test:Test, e:AssertionFailedError):Void {
		printf("F");
	}
	
	public function endTest(test:Test):Void {
	}
	
	private function createTextArea():Void {
		textArea = getTextField("textArea", 2);
	}
	
	private function createOutput():Void {
		traceOutput = getTextField("output", 4);
		traceOutput._visible = false;
		var format:TextFormat = traceOutput.getTextFormat();
		format.align = "right";
		traceOutput.setNewTextFormat(format);
	}

	private function getTextField(name:String, depth:Number):TextField {
		this.createTextField(name, depth, 0, 0, 100, 100);
		var textField:TextField = this[name];
		textField.wordWrap = true;
		textField.multiline = true;
		var format:TextFormat = new TextFormat();
		format.font = "Verdana";
		format.color = fontColor;
		format.size = 11;
		format.leftMargin = spacing/2;
		format.rightMargin = spacing/2;
		textField.setNewTextFormat(format);
		return textField;
	}
	
	private function createSuccessBar():Void {
		bar = SuccessBar(attachMovie(SuccessBar.linkageId, "bar", 3));
	}

	private function onResize():Void {
		draw();
	}
	
	public function draw():Void {
		var w:Number = Stage.width;
		var h:Number = Stage.height;
		drawBackground(w, h);
		drawTextArea(w, h);
		drawOutput(w, h);
		drawBar(w, h);
	}
	
	private function drawBackground(w:Number, h:Number):Void {
		clear();
		beginFill(bgColor);
		lineTo(w, 0);
		lineTo(w, h);
		lineTo(0, h);
		lineTo(0, 0);
		endFill();
	}
	
	private function drawTextArea(w:Number, h:Number):Void {
		drawTextField(textArea, w, h);
	}
	
	private function drawOutput(w:Number, h:Number):Void {
		drawTextField(traceOutput, w, h);
	}

	private function drawTextField(ref:TextField, w:Number, h:Number):Void {
		ref._width = w - (spacing*2);
		ref._height = h - (barHeight + (spacing*2));
		ref._x = spacing;
		ref._y = spacing;
	}

	private function drawBar(w:Number, h:Number):Void {
		bar._x = 0;
		bar._y = h - (barHeight);
		bar.width = w;
		bar.height = barHeight;
	}
	
	public function setShowTrace(showTrace:Boolean):Void {
		this.showTrace = showTrace;
	}
	
	public function getShowTrace():Boolean {
		return showTrace;
	}
	
	public function printResult(result:TestResult, runTime:Number):Void {
		printHeader(runTime);
	    printErrors(result);
	    printFailures(result);
	    printFooter(result);

	    bar.setSuccess(result.wasSuccessful());
	    if(showTrace) {
		    trace(textArea.text.split("\r").join("\n"));
	    }
	}

	private function printHeader(runTime:Number):Void {
		println();
		println();
		println("Time: " + elapsedTimeAsString(runTime));
	}
	
	/**
	 * Returns the formatted string of the elapsed time.
	 * Duplicated from BaseTestRunner. Fix it.
	 */
	private function elapsedTimeAsString(runTime:Number):String {
		return Number(runTime/1000).toString();
	}

	private function printErrors(result:TestResult):Void {
		printDefects(result.errors(), result.errorCount(), "error");
	}
	
	private function printFailures(result:TestResult):Void {
		printDefects(result.failures(), result.failureCount(), "failure");
	}
	
	private function printDefects(booBoos:Array, count:Number, type:String):Void {
		if (count == 0) {
			return;
		}
		if (count == 1) {
			println("There was " + count + " " + type + ":");
		}
		else {
			println("There were " + count + " " + type + "s:");
		}
		var item:TestFailure;
		var len:Number = booBoos.length;
		for(var i:Number = 0; i < len; i++) {
			printDefect(TestFailure(booBoos[i]), i);
		}
	}
	
	public function printDefect(booBoo:TestFailure, count:Number ):Void { // only public for testing purposes
		printDefectHeader(booBoo, count);
		printDefectTrace(booBoo);
	}

	private function printDefectTrace(booBoo:TestFailure):Void {
		println(BaseTestRunner.getFilteredTrace(booBoo.thrownException().toString()));
	}

	private function printDefectHeader(booBoo:TestFailure, count:Number):Void {
		// I feel like making this a println, then adding a line giving the throwable a chance to print something
		// before we get to the stack trace.
		var startIndex:Number = textArea.text.length;
		println(count + ") " + booBoo.failedTest());
		var endIndex:Number = textArea.text.length;

		var format:TextFormat = textArea.getTextFormat();
		format.bold = true;

		// GROSS HACK because of bug in flash player - TextField isn't accepting formats...
//		setTimeout(onFormatTimeout, 1, format, startIndex, endIndex);
	}

	private function printFooter(result:TestResult):Void {
		println();
		if (result.wasSuccessful()) {
			printf("OK");
			println (" (" + result.runCount() + " test" + (result.runCount() == 1 ? "": "s") + ")");
		} else {
			println("FAILURES!!!");
			println("Tests run: " + result.runCount()+ 
				         ",  Failures: "+result.failureCount()+
				         ",  Errors: "+result.errorCount());
		}
	    println();
	}
		
	public static var serializable:Boolean = Object.registerClass(linkageId, classRef);
}