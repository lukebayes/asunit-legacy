Stage.align = "TL";
Stage.scaleMode = "noScale";

// import com.asunit.util.*;
// var at:AllTests = new AllTests();

//import Output;
import com.asunit.ui.*;

function loadUi() {
	if(unit_mc != undefined) {
			Stage.removeListener(unit_mc);
			unit_mc.removeMovieClip();
			delete unit_mc;
			intervalId = setInterval(this, "loadUi", 500);
			return;
	}
	clearInterval(intervalId);
	unit_mc = attachMovie(Main.linkageId, "unitClip", 1);
}

loadUi();

