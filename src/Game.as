package
{	
	import events.NavigationEvent;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import model.ApplicationConst;
	
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
		private var currentScreen:String = ApplicationConst.SCREEN_WELCOME;
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
			
			screenWelcome.initialize();
			//screenGame.initialize();
			//soundChannel = new SoundChannel();
			
			
			playBackgroundSound();
		}
		
		private function playBackgroundSound():void {
			var backgroundSound:Sound = new Assets.Sound_Background();
			var soundTransform:SoundTransform = new SoundTransform();
			soundChannel = backgroundSound.play();
			
			if(currentScreen == ApplicationConst.SCREEN_GAME) {
				soundTransform.volume = 0.05;
				soundChannel.soundTransform = soundTransform;
			}
			soundChannel.addEventListener(flash.events.Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		private function onSoundComplete(event:flash.events.Event):void {
			soundChannel.removeEventListener(flash.events.Event.SOUND_COMPLETE, onSoundComplete);
			playBackgroundSound();
		}
		
		private function changeScreenHandler(event:NavigationEvent):void {
			currentScreen = event.params.id;
			switch(currentScreen) {
				case ApplicationConst.SCREEN_WELCOME:
					setVolume(1);
					screenGame.disposeTemporarily();
					screenFeedback.disposeTemporarily();
					screenWelcome.initialize();					
					break;
				
				case ApplicationConst.SCREEN_GAME:
					setVolume(0.05);
					screenWelcome.disposeTemporarily();
					screenFeedback.disposeTemporarily();
					screenGame.initialize();
					break;
				
				case ApplicationConst.SCREEN_FEEDBACK:
					setVolume(1);
					screenFeedback.score = screenGame.score;
					screenWelcome.disposeTemporarily();
					screenGame.disposeTemporarily();
					screenFeedback.initialize();
					break;
			}
		}
		
		private function setVolume(value:Number):void {
			var soundTransform:SoundTransform = new SoundTransform();
			soundTransform.volume = value;
			soundChannel.soundTransform = soundTransform;
		}
		
	}
}