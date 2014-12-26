package objects
{
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
	import dragonBones.events.AnimationEvent;
	import events.SheepEvent;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class Sheep extends Sprite
	{
		private var sheep:Armature;
		private var txt:TextField;
		private var sheepValue:Number;
		public var answer:Boolean;
		private var sndChannelFeedback:SoundChannel;
		public function Sheep()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
		}

		private function onAddedToStage(event:starling.events.Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initEvents();
			createArt();
		}
		
		private function initEvents():void {
			this.addEventListener(starling.events.TouchEvent.TOUCH, touchHandler);
		}
		
		private function touchHandler(event:starling.events.TouchEvent):void {
			var touches:Vector.<Touch> = event.getTouches(this);
			var clicked:DisplayObject = event.currentTarget as DisplayObject;
			if ( touches.length == 1 )
			{
				var touch:Touch = touches[0];   
				if ( touch.phase == TouchPhase.BEGAN ){
					this.scaleX = this.scaleY = 0.9;
				}
				if ( touch.phase == TouchPhase.ENDED )
				{
					this.scaleX = this.scaleY = 1;
					this.touchable = false;
					var sound:Sound;
					if(answer == true) {
						sound = new Assets.Sound_Feedback_Correct();
					} else {
						sound = new Assets.Sound_Feedback_Incorrect();
					}
					sndChannelFeedback = sound.play();
					sndChannelFeedback.addEventListener(flash.events.Event.SOUND_COMPLETE, feedbackSoundCompleteHandler);
					this.dispatchEvent(new SheepEvent(SheepEvent.FEEDBACK, {feedback:answer}, true));
				}
			}	
		}
		
		private function feedbackSoundCompleteHandler(event:flash.events.Event):void {
			sndChannelFeedback.removeEventListener(flash.events.Event.SOUND_COMPLETE, feedbackSoundCompleteHandler);
			this.dispatchEvent(new SheepEvent(SheepEvent.FEEDBACK_COMPLETE, {feedback:answer}, true));
		}
		
		public function initialize(positionX:Number, positionY:Number, value:Number, answer:Boolean = false):void {
			this.visible = true;
			this.x = positionX;
			this.y = positionY;
			this.answer = answer;
			sheepValue = value;
			txt.text = String(value);
			this.touchable = true;
		}
		
		private function createArt():void {
			sheep = Assets.getArmature("sheep");
			sheep.addEventListener(AnimationEvent.COMPLETE, animationCompleteHandler);
			sheep.animation.play();
			WorldClock.clock.add(sheep);
			this.addChild(sheep.display as Sprite);
			
			txt = new TextField(75, 75, "", Assets.getFont().name, 36);
			txt.x = - txt.width/4;
			txt.y = - txt.height/3;
			this.addChild(txt);
		}
		
		private function animationCompleteHandler(event:AnimationEvent):void {
			event.currentTarget.animation.play();
		}
		
		public function disposeTemporarily():void {
			this.visible = false;
		}
	}
}