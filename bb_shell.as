package{
	
	import com.plusk.PKBannerAd;
	import flash.display.*;
	
	// import fl.transitions.easing.Regular;
	// import fl.transitions.easing.Back;
	// import fl.transitions.easing.Strong;
	
	// import flash.events.MouseEvent;
	// import flash.events.Event;
	
	// import flash.utils.Dictionary;
	
	public class bb_shell extends PKBannerAd {
		
		// DECLARE VARIABLES HERE
		// public var positions:Dictionary;
		
		public function bb_shell(){
			super();
			
			
		}
		
		// init
		public override function init():void {
			stop();
			
			init_frame(); // init.
		
			// addReplayButton( cta_mc as MovieClip ); // SET UP REPLAY BUTTON
			// addExitButton( pan_mc as MovieClip ); // SET UP EXIT BUTTON
			
			
			// populate frameMan
			fMan.addFrame( frame_1, 5000 );
			fMan.addFrame( frame_2 ); // LAST FRAME DOES NOT REQUIRE A TIME
			
			fMan.start();

		}
		
		
		// USE IN CASE NON-STANDARD CLICKTAG IS REQUIRED
		/* override public function doExit( e:MouseEvent ):void {
			trace("click");
			var sURL:String;
			if ((sURL = root.loaderInfo.parameters.clickTag)) {
				openWindow(sURL);
			}
		} */
		
		public function init_frame(){ // SET YOUR VARIABLES HERE, MOVE CLIPS INTO POSITION, ETC.
		}
		
		public function frame_1(){ // FRAME 1 ANIMATION
			
		} 
		public function frame_2() { // FRAME 2 ANIMATION
			
		}
		

	}
}