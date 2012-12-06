package{
	
	import com.plusk.PKBannerAd;
	import flash.display.*;
	import fl.transitions.easing.Regular;
	import fl.transitions.easing.Elastic;
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import flash.utils.Dictionary;
	
	public class lb_shell extends PKBannerAd {
		
		public var finalframe:Array;
		
		static public var numText = 2;
		static public var pan_ty = 0;
		
		public var positions:Dictionary;
		
		public function lb_shell(){
			
			super();
			trace("hell0 lb_shell");
			
			positions = new Dictionary();
			
			finalframe = [];
			
			
			addCTA( cta_mc as MovieClip );
			
			frame_0(); // init.
			// populate frameMan
			//fMan.addFrame( frame_0, 0 );
			fMan.addFrame( frame_1, 5000 );
			fMan.addFrame( frame_2, 3000 );
			fMan.addFrame( frame_3, 1000 );
			fMan.addFrame( frame_4 );
			
			fMan.start();
			
			
			stop();
		}
		
		public function clickHandler( e:Event ):void {
			trace ("clicked");
			// exit.
		}
		
		public function frame_0(){
			trace ("frame 0");
			// init image.
			positions[pan_mc] = pan_ty; // set from timeline
			
			// init popup text.
			popuptxt_mc.scaleX = popuptxt_mc.scaleY = 0;
			
			
			// init final frame text.
			for (var i=1;i<=numText;i++){ // set from timeline
				finalframe.push(this["txt"+i+"_mc"]);
			}
			
			finalframe.push(cta_mc);
			finalframe.push(logo_mc);
			for (i=0;i<finalframe.length;i++){
				var clip = finalframe[i];
				clip.alpha = 0;
				positions[clip] = clip.x;
				clip.x += 100;
			}
			legal_mc.alpha = 0;
		}
		
		public function frame_1(){ // PAN
			trace ("frame 1");
			
			tMan.to(pan_mc, "y", positions[pan_mc], 4, Regular.easeInOut, null, 1);
			
			// testing commit.
			
			//fMan.stop();
		} 
		public function frame_2() { // POP TEXT
			trace ("frame 2");
			tMan.to(popuptxt_mc,["scaleX","scaleY"],[1,1],1,Elastic.easeOut);
		}
		public function frame_3() { // HIDE IMAGE, SLIDE IN TEXT
			trace ("frame 3");
			tMan.to(pan_mc,"alpha",0,.5);
			tMan.to(popuptxt_mc,"alpha",0,.5);
			
			
			for (var i=0;i<finalframe.length;i++){
				var clip = finalframe[i];
				
				tMan.to(clip, ["x","alpha"], [positions[clip],1], 1, null, null, i/10);
			}
		}
		public function frame_4() { // BRING IN LEGAL
			//pan_mc.visible = false;
			trace ("frame 4");
			tMan.to(legal_mc,"alpha",1,1);
		}

	}
}