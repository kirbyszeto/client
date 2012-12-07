package com.plusk {
	
	import flash.display.MovieClip;
	import com.plusk.tweenMan;
	import com.plusk.frameMan;
	import flash.events.MouseEvent;
	
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	
	public class PKBannerAd extends MovieClip {
		public var tMan:tweenMan;
		public var fMan:frameMan;
		
		public function PKBannerAd() {
			tMan = tweenMan.getInstance();
			fMan = new frameMan( this );
			
			addFrameScript ( 2 , init ) ;
			
		}
		
		public function init():void {
			trace("default init");
			stop();
		}
		
		public function addReplayButton( d:MovieClip ):void {
			d.buttonMode = true;
			d.mouseChildren = false;
			d.addEventListener( MouseEvent.CLICK, doReplay );
		}
		public function doReplay( e:MouseEvent ):void {
			gotoAndPlay(1);
		}
		public function addExitButton( d:MovieClip ):void {
			d.buttonMode = true;
			d.mouseChildren = false;
			d.addEventListener( MouseEvent.CLICK, doExit );
		}
		public function doExit( e:MouseEvent ):void {
			trace("click");
			var sURL:String;
			if ((sURL = root.loaderInfo.parameters.clickTag)) {
				openWindow(sURL);
			}
		}
		private function getBrowserName():String {
			var b:String; // browser
			//Uses external interface to reach out to browser and grab browser useragent info.
			var bA:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}"); // browser agent
			//Determines brand of browser using a find index. If not found indexOf returns (-1).
			if(bA != null && bA.indexOf("Firefox")>= 0) {
				b = "Firefox";
			} else if(bA != null && bA.indexOf("Chrome")>= 0) {
				b = "Chrome";
			} else if(bA != null && bA.indexOf("Safari")>= 0){
				b = "Safari";
			} else if(bA != null && bA.indexOf("MSIE")>= 0){
				b = "IE";
			} else if(bA != null && bA.indexOf("Opera")>= 0){
				b = "Opera";
			} else {
				b = "Undefined";
			}
			return (b);
		}
		private function openWindow(url:String, target:String = '_blank', features:String=""):void {
			var WINDOW_OPEN_FUNCTION:String = "window.open";
			var myURL:URLRequest = new URLRequest(url);
			var bN:String = getBrowserName(); // browser name
			switch (bN) {
				//If browser is Firefox, use ExternalInterface to call out to browser
				//and launch window via browser's window.open method.
				case "Firefox":
				case "Chrome":
					ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, target, features);
				    break;
				//If IE,
				case "IE":
					ExternalInterface.call("function setWMWindow() {window.open('" + url + "', '"+target+"', '"+features+"');}");
					break;
				// If Safari or Opera or any other
				/* case "Safari":
					navigateToURL(myURL, target);
					break;
				case "Opera":
					navigateToURL(myURL, target);
					break; */
				default:
					navigateToURL(myURL, target);
					break;
			}
		}
	}
	
}