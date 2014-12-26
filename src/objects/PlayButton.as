package objects
{
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
	import dragonBones.events.AnimationEvent;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class PlayButton extends Sprite
	{
		private var btnPlay:Armature;
		
		public function PlayButton() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createButtonArt();
		}
		
		private function createButtonArt():void {
			btnPlay = Assets.getArmature("playBtn");
			btnPlay.name = "btnPlay";
			//btnPlay.display.x = 397.4;
			//btnPlay.display.y = 354.5;
			this.addChild(btnPlay.display as Sprite);
			btnPlay.addEventListener(AnimationEvent.COMPLETE, animationCompleteHandler);
			btnPlay.animation.play();
			WorldClock.clock.add(btnPlay);			
		}
		
		private function animationCompleteHandler(event:AnimationEvent):void {
			event.currentTarget.animation.play();
		}
	}
}