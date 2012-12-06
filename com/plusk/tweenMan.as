package com.plusk {
	
	import fl.transitions.Tween;
	import fl.transitions.easing.Strong;
	import fl.transitions.TweenEvent;
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	public class tweenMan {
		
		private static var tM:tweenMan;
		static public var d:Dictionary; // for tracking tweens
		static public var oC:Dictionary;
		
		private static var tt:String = "flash.utils::Timer"; // timer type.
		private static var dt:String = "display"; // display type.
		private static var tp:String = "_tween"; // tween post-fix
		
		public function tweenMan(){
			d = new Dictionary(); 
			oC = new Dictionary();
		}
		
		static public function getInstance():tweenMan {
			if (tM == null){
				tM = new tweenMan();
			}
			
			return tM;
		}
		
		
		public function to(clip,properties,targets,duration,easing=null,oncomplete=null,delay=null){

			var c = clip;
			var p = properties;
			var t = targets;
			var u = duration;
			var m = easing;
			var o = oncomplete;
			var e = delay;
			
			d[c] = new Object();
			
			if (typeof p == "string") { // throw it in an array if it isn't already in one.
				p = [p];
				t = [t];
			}
			
			if (e!=undefined){				
				var j = new Timer(e*1000,1);
				j.addEventListener(TimerEvent.TIMER_COMPLETE, dt_fn);
				d[j] = [ c,p,t,u,m,o ];
				j.start();
			} else {
				if (m==null) m = Strong.easeOut;
				
				for (var i=0;i<p.length;i++){
					d[c][p[i]+tp] = new Tween(c, p[i], m, c[p[i]], t[i], u, true);
					d[c][p[i]+tp].addEventListener(TweenEvent.MOTION_FINISH, oC_fn);
				}
				
				if (o!=null){ // only gets applied to first property
					oC[ d[c][p[0]+tp] ] = o;
				}
				
			}
		}
		
		public function oC_fn (e:TweenEvent):void {
			// trace ("event: " + oC[ event.currentTarget ] );
			var tween:Tween = e.currentTarget as Tween;
			tween.removeEventListener( TweenEvent.MOTION_FINISH, oC_fn );
			var clip = tween.obj;
			delete d[clip][tween.prop+tp];
			
			if ( oC[ tween ] ){
				oC[ tween ]();
				delete oC[ tween ];
			}
		}
		
		public function dt_fn( e:TimerEvent ){		
			var a = d[e.currentTarget];
			if (a) {
				// trace ("timer fire: " + a[0].name);
				to(a[0],a[1],a[2],a[3],a[4],a[5]);
				delete d[e.currentTarget];
			}
		}
		
		public function getTween( c, prop ):Tween {
			return d[c][prop+tp];
		}
		public function addMotionChange( c, prop, f ) {
			var t = getTween(c, prop);
			t.addEventListener(TweenEvent.MOTION_CHANGE,f);
		}
		
		public function killTween(c){
			for (var e in d){
				var scn = getQualifiedSuperclassName(e);
				var cn = getQualifiedClassName(e);
				if ( scn.indexOf(dt)>-1 ){ // check if it is a display object
					if (e==c){
						for (var j in d[e]){
							d[e][j].stop();
						}
					}
				} else if ( cn==tt ) { // check if it is a timer
					if (d[e][0]==c){
						e.stop();
					}
				}
			}
		}
		public function resumeTween(c){
			for (var e in d){
				var scn = getQualifiedSuperclassName(e);
				var cn = getQualifiedClassName(e);
				if ( scn.indexOf(dt)>-1 ){ // check if it is a display object
					if (e==c){
						for (var j in d[e]){
							d[e][j].resume();
						}
					}
				} else if ( cn==tt ) { // check if it is a timer
					e.start();
				}
			}
		}
		public function killAllTweens() {
			for (var e in d){
				var scn = getQualifiedSuperclassName(e);
				var cn = getQualifiedClassName(e);
				if ( scn.indexOf(dt)>-1 ){ // check if it is a display object
						for (var j in d[e]){
							d[e][j].stop();
						}
				} else if ( cn==tt ) { // check if it is a timer
						e.stop();
				}
			}
		}
	}
}