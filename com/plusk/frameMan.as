/* *********************************************
as.frameMan
************************************************

Description:	frame-based animation manager

Creation date:	Tue Oct 02 2007
Created by:	Kirby Szeto (K0 Studios)
Modified:	-
Notes:	-

***********************************************/

package com.plusk {

	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;

	
	
	public class frameMan {	

		// class definition
		
		// variables
		var fTimer:Timer;
		var frameTimes:Array;
		
		var frame:Array; // array of functions.
		var currentframe:Number;
		
		var parentObj;
		
	
		// public var init:Function;	
		
		public function frameMan ( thisObj ) {
			
			parentObj = thisObj;
			
			frameTimes = [ null ]; // pre-populate those so that all frame references are 1-relative.
			frame = [ null ];
		}
		
		public function addFrame( f:Function, t:Number=-1 ):void {
			frame.push(f);
			if (t>=0) frameTimes.push(t);
		}
		public function frameTime( fNum:Number, t:Number = 0 ):void {
			frameTimes[ fNum ] = t;
		}
		
		public function start(){

			if (frame.length == 1) {
				trace ("no frames");
				return;
			}
			
			// begin.
			resume(1);
		}
		
		public function stop(){
			trace ("stop " + fTimer);
			if(fTimer!=null){	
				fTimer.stop();
			}
		}
		
		public function resume(num=null){
			currentframe = (num!=null) ? num : currentframe+1;
			//frame[currentframe].apply( parentObj );
			// begin.
			//fTimer = new Timer(frameTimes[currentframe],1);
			//currentframe++;
			//fTimer.addEventListener(TimerEvent.TIMER_COMPLETE, goFrame);
			//fTimer.start();
			
			goFrame( null );
		}
		
		private function goFrame( e:Event ){
			var num = currentframe;
			
			if (currentframe<frameTimes.length){
				
				fTimer = new Timer(frameTimes[currentframe],1);
				currentframe++;
				fTimer.addEventListener(TimerEvent.TIMER_COMPLETE, goFrame);
				fTimer.start();
				
			}
			
			if (frame[num]){
				frame[num].apply( parentObj );
			} else {
				trace("frame " + num + " does not exist");
			}
		}
	
	}
}