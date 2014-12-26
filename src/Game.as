package
{	
	import events.NavigationEvent;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import screens.ScreenFeedback;
	import screens.ScreenGame;
	import screens.ScreenWelcome;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var screenWelcome:ScreenWelcome;
		private var screenGame:ScreenGame;
		private var screenFeedback:ScreenFeedback;
		private var soundChannel:SoundChannel;
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:starling.events.Event):void {
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, changeScreenHandler);
			
			screenGame = new ScreenGame();
			screenGame.disposeTemporarily();
			this.addChild(screenGame);
			
			screenWelcome = new ScreenWelcome();
			screenWelcome.disposeTemporarily();
			this.addChild(screenWelcome);
			
			screenFeedback = new ScreenFeedback();
			screenFeedback.disposeTemporarily();
			this.addChild(screenFeedback);
			
			//screenWelcome.initialize();
			screenGame.initialize();
			//soundChannel.addEventListener(flash.events.Event.SOUND_COMPLETE, onSoundComplete);
			
			playBackgroundSound();
		}
		
		private function playBackgroundSound():void {
			var sound_1:Sound = new Assets.Sound_Background();
			soundChannel = sound_1.play();
		}
		
		private function onSoundComplete(event:flash.events.Event):void {
			playBackgroundSound();
		}
		
		private function changeScreenHandler(event:NavigationEvent):void {
			switch(event.params.id) {
				case "play":
					screenGame.disposeTemporarily();
					screenFeedback.disposeTemporarily();
					screenWelcome.initialize();
					break;
				
				case "welcome":
					screenWelcome.disposeTemporarily();
					screenFeedback.disposeTemporarily();
					screenGame.initialize();
					break;
				
				case "feedback":
					screenWelcome.disposeTemporarily();
					screenGame.disposeTemporarily();
					screenFeedback.initialize();
					break;
			}
		}
		
		
	}
}