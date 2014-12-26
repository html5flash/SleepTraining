package objects
{
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
	import dragonBones.events.AnimationEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Sheep extends Sprite
	{
		private var sheep:Armature;
		private var txt:TextField;
		private var sheepValue:Number;
		public function Sheep()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}

		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createArt();
		}
		
		public function initialize(positionX:Number, positionY:Number, value:Number):void {
			this.visible = true;
			this.x = positionX;
			this.y = positionY;
			sheepValue = value;
			txt.text = String(value);
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