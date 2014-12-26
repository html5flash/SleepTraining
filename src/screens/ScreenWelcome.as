package screens
{
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
	import dragonBones.events.AnimationEvent;
	
	import events.NavigationEvent;
	
	import model.ApplicationConst;
	
	import objects.PlayButton;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ScreenWelcome extends Sprite
	{
		private var bg:Image;
		private var title:Armature;
		private var btnPlaySprite:Sprite;
		private var btnPlay:PlayButton;
		private var sheep_1:Armature;
		private var sheep_2:Armature;
		private var sheep_3:Armature;
		private var sheep_4:Armature;
		
		public function ScreenWelcome()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			trace("welcome screen initialized");
			drawScreen();
		}
		
		private function drawScreen():void {
			bg = new Image(Assets.getTexture("BgWelcome"));
			this.addChild(bg);			
			
			title = Assets.getArmature("title");
			title.display.x = 381.95;
			title.display.y = 206.6;
			this.addChild(title.display as Sprite);
			title.animation.play();
			WorldClock.clock.add(title);
			
			btnPlay = new PlayButton();
			btnPlay.name = "btnPlay";
			btnPlay.x = 397.4;
			btnPlay.y = 354.5;
			btnPlay.addEventListener(TouchEvent.TOUCH, onPlay);
			this.addChild(btnPlay as Sprite);
		}
		
		private function onPlay(event:TouchEvent):void {
			var touches:Vector.<Touch> = event.getTouches(this);
			var clicked:DisplayObject = event.currentTarget as DisplayObject;
			if ( touches.length == 1 )
			{
				var touch:Touch = touches[0];   
				if ( touch.phase == TouchPhase.ENDED )
				{
					//trace ( e.currentTarget, e.target );
					trace("onPlay============== ");
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id:ApplicationConst.SCREEN_GAME},true));
				}
			}			
		}
		
		public function initialize():void {
			this.visible = true;
		}
		
		private function onEnterFrameHandler(evt:EnterFrameEvent):void {
			WorldClock.clock.advanceTime(-1);
		}
		
		private function animationCompleteHandler(event:AnimationEvent):void {
			event.currentTarget.animation.play();
		}
		
		public function disposeTemporarily():void {
			this.visible = false;
		}		
	}
}