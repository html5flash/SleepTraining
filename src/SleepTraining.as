package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.SystemUtil;
	
	[SWF(width="768", height="450", frameRate="50", backgroundColor="0xFFFFFF")]
	public class SleepTraining extends Sprite
	{
		private const StageWidth:int  = 768;
		private const StageHeight:int = 450;
		private var _starling:Starling;	
		
		public function SleepTraining()
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			addEventListener(flash.events.Event.ADDED_TO_STAGE, initializeGame);
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, appDeactivateHandler);
		}
		
		private function appDeactivateHandler(event:flash.events.Event):void {
			//NativeApplication.nativeApplication.exit();
		}
		
		private function initializeGame(event:flash.events.Event):void
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, initializeGame);
			//stage.nativeWindow.addEventListener(flash.events.Event.CLOSING, onCloseCall);
			
			
			initializeStarlingFramework();
		}
		
		private function onCloseCall(event:flash.events.Event):void
		{
			//event.preventDefault();
		}
		
		private function initializeStarlingFramework():void
		{			
			var iOS:Boolean = SystemUtil.platform == "IOS";
			var stageSize:Rectangle  = new Rectangle(0, 0, StageWidth, StageHeight);
			var screenSize:Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			var viewPort:Rectangle = RectangleUtil.fit(stageSize, screenSize, ScaleMode.SHOW_ALL, iOS);
			var scaleFactor:int = viewPort.width < StageWidth ? 1 : 2; // midway between 320 and 640
			if(viewPort.width < StageWidth) {
				scaleFactor = viewPort.height/StageHeight;
			} else {
				scaleFactor = viewPort.height/StageHeight;
			}
			//_starling.multitouchEnabled = true; // useful on mobile devices
			//_starling.handleLostContext = true; // recommended everywhere when using AssetManager
			
			_starling = new Starling(Game, stage, viewPort, null, "auto", "auto");
			_starling.stage.stageWidth    = StageWidth;  // <- same size on all devices!
			_starling.stage.stageHeight   = StageHeight; // <- same size on all devices!
			//_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.simulateMultitouch  = false;			
			
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, function():void
			{				 
				initElements(scaleFactor);
			}); 
		}	
		
		private function initElements(scaleFactor:int):void
		{
			var game:Game = _starling.root as Game;
			game.scaleX = 1/scaleFactor;
			game.scaleY = 1/scaleFactor; 
			
			_starling.start();
		}
	}
}