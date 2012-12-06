package com.plusk {
	
	import flash.display.MovieClip;
	import com.plusk.tweenMan;
	import com.plusk.frameMan;
	import flash.events.MouseEvent;
	
	
	public class PKBannerAd extends MovieClip {
		public var tMan:tweenMan;
		public var fMan:frameMan;
		
		public function PKBannerAd() {
			trace ("hello new banner ad!");
			tMan = tweenMan.getInstance();
			fMan = new frameMan( this );
		}
		
		public function addCTA( d:MovieClip ):void {
			d.buttonMode = true;
			d.mouseChildren = false;
			d.addEventListener( MouseEvent.CLICK, handleCTAClick );
		}
		private function handleCTAClick( e:MouseEvent ):void {
			
		}
	}
	
}