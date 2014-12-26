package screens
{
	import com.greensock.TweenLite;
	
	import events.NavigationEvent;
	
	import flash.media.Sound;
	
	import objects.Lobao;
	import objects.Sheep;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import utils.AudioController;
	import utils.RandomUtil;
	
	public class ScreenGame extends Sprite
	{
		private var time:Image;
		private var bg:Image;
		private var sheep_1:Sheep;
		private var sheep_2:Sheep;
		private var sheep_3:Sheep;
		private var sheep_4:Sheep;
		private var sheep_5:Sheep;
		private var sheep_6:Sheep;
		private var randomNumbers:Array;
		
		public function ScreenGame()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			trace("welcome screen initialized");
			drawScreen();
		}
		
		private function drawScreen():void {
			time = new Image(Assets.getTexture("Time"));
			//time.alpha = 0.5;
			time.x = 160;
			time.y = 0;
			//time.y = -530;
			var tween:TweenLite = TweenLite.fromTo(time,600,{y:0}, {y:-530, onComplete:onTimeUp});	
			
			this.addChild(time);
			
			bg = new Image(Assets.getTexture("BgGamePlay"));
			this.addChild(bg);
			
			var lobao:Lobao = new Lobao();
			this.addChild(lobao);
			lobao.gotoAndPlay("inicio");
			
			sheep_1 = new Sheep();
			this.addChild(sheep_1);
			
			sheep_2 = new Sheep();
			this.addChild(sheep_2);
			
			sheep_3 = new Sheep();
			this.addChild(sheep_3);
			
			sheep_4 = new Sheep();
			this.addChild(sheep_4);
			
			sheep_5 = new Sheep();
			this.addChild(sheep_5);
			
			
			sheep_6 = new Sheep();
			this.addChild(sheep_6);
			
		}
		
		public function initialize():void {
			this.visible = true;
			randomNumbers = RandomUtil.generateRandomNumbers(1,15);
			
			sheep_1.initialize(200,100,randomNumbers[0]);
			sheep_2.initialize(100,225,randomNumbers[1]);
			sheep_3.initialize(210,350,randomNumbers[2]);
			sheep_4.initialize(555,95,randomNumbers[3]);
			sheep_5.initialize(660,220,randomNumbers[4]);
			sheep_6.initialize(615,340,randomNumbers[5]);
			
			var sound_1:Sound = new Assets.Sound_1();
			
			AudioController.getInstance().playAudioClips([sound_1],onAudioComplete);
		}
		
		private function onAudioComplete(currentIndex:Number,count:Number):void {
			trace("audio play completed");
		}
		
		private function onTimeUp():void {
			dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id:"feedback"},true));
		}
		
		public function disposeTemporarily():void {
			this.visible = false;
		}
	}
}