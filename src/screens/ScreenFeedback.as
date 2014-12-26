package screens
{
	import com.greensock.TweenLite;
	
	import events.NavigationEvent;
	
	import model.ApplicationConst;
	
	import objects.Lobao;
	import objects.Sheep;
	import objects.StarRating;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class ScreenFeedback extends Sprite
	{
		private var time:Image;
		private var bg:Image;
		private var txt:TextField;
		private var sheep_1:Sheep;
		private var btnReplay:Button;
		private var starRating:StarRating;
		public var score:Number = 0;
		
		public function ScreenFeedback()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawScreen();
		}
		
		private function drawScreen():void {
			time = new Image(Assets.getTexture("Time"));
			time.x = 160;
			time.y = 0;
			TweenLite.fromTo(time,10,{y:0}, {y:-530});
			this.addChild(time);
			
			bg = new Image(Assets.getTexture("BgGamePlay"));
			this.addChild(bg);
			
			var lobao:Lobao = new Lobao();
			//this.addChild(lobao);
			//lobao.gotoAndPlay("inicio");
			
			//sheep_1 = new Sheep();
			//this.addChild(sheep_1);
			
			txt = new TextField(75, 75, "", Assets.getFont().name, 36);
			txt.x = this.stage.stageWidth/2 - txt.width/2;
			txt.y = 200;
			//this.addChild(txt);
			
			btnReplay = new Button(Assets.getTexture("ReplayButton"));
			btnReplay.x = this.stage.stageWidth/2 - btnReplay.width/2;
			btnReplay.y = 300;
			btnReplay.addEventListener(starling.events.Event.TRIGGERED, replayHandler);
			this.addChild(btnReplay);
			
			starRating = new StarRating();
			this.addChild(starRating);
			starRating.x = this.stage.stageWidth/2 - starRating.width/2;
			starRating.y = 170;
		}
		
		private function replayHandler(event:starling.events.Event):void {
			dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id:ApplicationConst.SCREEN_WELCOME},true));
		}
		
		public function initialize():void {
			this.visible = true;
			starRating.initialize(score);
			//txt.text = "" + score + "/" + ApplicationConst.MAX_LIMIT;
		}
		
		public function disposeTemporarily():void {
			this.visible = false;
		}
	}
}