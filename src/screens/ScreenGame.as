package screens
{
	import com.greensock.TweenLite;
	
	import events.NavigationEvent;
	import events.SheepEvent;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import model.ApplicationConst;
	
	import objects.Lobao;
	import objects.Sheep;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	import utils.RandomUtil;
	
	public class ScreenGame extends Sprite
	{
		private var time:Image;
		private var bg:Image;
		private var lobao:Lobao;
		private var sheep_1:Sheep;
		private var sheep_2:Sheep;
		private var sheep_3:Sheep;
		private var sheep_4:Sheep;
		private var sheep_5:Sheep;
		private var sheep_6:Sheep;
		private var sndChannelFeedback:SoundChannel;
		private var sndChannelNumber:SoundChannel;
		private var index:Number = 0;
		private var tween:TweenLite;
		public var score:Number = 0;
		private var positionSheep:Array = [	{x:200, y:100},
											{x:100, y:225},
											{x:210, y:350},
											{x:555, y:95},
											{x:660, y:220},
											{x:615, y:340}];
		
		public function ScreenGame()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:starling.events.Event):void {
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(SheepEvent.FEEDBACK, sheepFeedbackHandler);
			this.addEventListener(SheepEvent.FEEDBACK_COMPLETE, sheepFeedbackCompleteHandler);
			drawScreen();
		}
		
		private function sheepFeedbackHandler(event:SheepEvent):void {
			if(event.params.feedback == true) {
				score++;
				lobao.showCorrectAnimation(true);
			} else {
				lobao.showCorrectAnimation(false);
			}
		}

		private function sheepFeedbackCompleteHandler(event:SheepEvent):void {
			hideOptions();
		}
		
		private function drawScreen():void {
			time = new Image(Assets.getTexture("Time"));
			time.x = 160;
			time.y = 0;
			tween = TweenLite.fromTo(time,ApplicationConst.GAME_TIME,{y:0}, {y:-530, onComplete:onTimeUp});
			
			this.addChild(time);
			
			bg = new Image(Assets.getTexture("BgGamePlay"));
			this.addChild(bg);
			
			lobao = new Lobao();
			this.addChild(lobao);			
			
			sheep_1 = new Sheep();
			sheep_1.disposeTemporarily();
			this.addChild(sheep_1);
			
			sheep_2 = new Sheep();
			sheep_2.disposeTemporarily();
			this.addChild(sheep_2);
			
			sheep_3 = new Sheep();
			sheep_3.disposeTemporarily();
			this.addChild(sheep_3);
			
			sheep_4 = new Sheep();
			sheep_4.disposeTemporarily();
			this.addChild(sheep_4);
			
			sheep_5 = new Sheep();
			sheep_5.disposeTemporarily();
			this.addChild(sheep_5);
			
			sheep_6 = new Sheep();
			sheep_6.disposeTemporarily();
			this.addChild(sheep_6);
		}
		
		public function initialize():void {
			tween = TweenLite.fromTo(time,ApplicationConst.GAME_TIME,{y:0}, {y:-530, onComplete:onTimeUp});
			this.visible = true;
			score = 0;
			lobao.gotoAndPlay("inicio");
			var soundHello:Sound = new Assets.Sound_Hello();
			sndChannelFeedback = soundHello.play();
			sndChannelFeedback.addEventListener(flash.events.Event.SOUND_COMPLETE, feedbackSoundCompleteHandler);
		}
		
		private function playNextSound():void {
			if(index <= ApplicationConst.MAX_LIMIT) {
				var sound:Sound = new Assets["Sound_"+index]();
				sndChannelNumber = sound.play();
				sndChannelNumber.addEventListener(flash.events.Event.SOUND_COMPLETE, numberSoundCompleteHandler);
			} else {
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id:ApplicationConst.SCREEN_FEEDBACK},true));
			}
		}
		
		private function feedbackSoundCompleteHandler(event:flash.events.Event):void {
			sndChannelFeedback.removeEventListener(flash.events.Event.SOUND_COMPLETE, feedbackSoundCompleteHandler);
			trace("feedback sound played");
			index++;
			playNextSound();
		}
		
		private function numberSoundCompleteHandler(event:flash.events.Event):void {
			sndChannelNumber.removeEventListener(flash.events.Event.SOUND_COMPLETE, numberSoundCompleteHandler);
			showOptions();
			index++;
		}
		
		private function showOptions():void {
			var randomNumbers:Array = RandomUtil.generateRandomNumbers(1,ApplicationConst.MAX_LIMIT);
			positionSheep = RandomUtil.randomSort(positionSheep);
			var sheepIndex:Number = 1;
			var randomIndex:Number = 0;
			while(sheepIndex <= ApplicationConst.OPTION_COUNT) {
				if(index != randomNumbers[randomIndex]) {
					(this["sheep_"+sheepIndex] as Sheep).initialize(positionSheep[sheepIndex-1].x, positionSheep[sheepIndex-1].y, sheepIndex==1?index:randomNumbers[randomIndex], sheepIndex==1?true:false);
					TweenLite.fromTo((this["sheep_"+sheepIndex] as Sheep),ApplicationConst.OPTION_FADE_IN_TIME,{alpha:0},{alpha:1});
					sheepIndex++;
				}
				randomIndex++;
			}
		}
		
		private function hideOptions():void {
			for(var i:Number =1; i <= ApplicationConst.OPTION_COUNT; i++) {
				if(i==1)
					TweenLite.fromTo((this["sheep_"+i] as Sheep),ApplicationConst.OPTION_FADE_IN_OUT,{alpha:1},{alpha:0, onComplete:hideCompleteHandler});
				else 
					TweenLite.fromTo((this["sheep_"+i] as Sheep),ApplicationConst.OPTION_FADE_IN_OUT,{alpha:1},{alpha:0});
			}
		}
		
		private function hideCompleteHandler():void {
			playNextSound();
		}
		
		private function onTimeUp():void {
			dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id:ApplicationConst.SCREEN_FEEDBACK},true));
		}
		
		public function disposeTemporarily():void {
			this.visible = false;
			index = 0;
			score = 0;
			if(sndChannelFeedback)
				sndChannelFeedback.stop();
			
			if(sndChannelNumber)
				sndChannelNumber.stop();
			
			if(time) {
				time.x = 160;
				time.y = 0;
			}
			
			if(sndChannelFeedback && sndChannelFeedback.hasEventListener(flash.events.Event.SOUND_COMPLETE)) {
				sndChannelFeedback.removeEventListener(flash.events.Event.SOUND_COMPLETE, feedbackSoundCompleteHandler);
			}
			if(tween)
				tween.kill();
		}
	}
}