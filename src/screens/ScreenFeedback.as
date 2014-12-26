package screens
{
	import com.greensock.TweenLite;
	import objects.Lobao;
	import objects.Sheep;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ScreenFeedback extends Sprite
	{
		private var time:Image;
		private var bg:Image;
		private var sheep_1:Sheep;
		
		public function ScreenFeedback()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			drawScreen();
		}
		
		private function drawScreen():void {
			time = new Image(Assets.getTexture("Time"));
			//time.alpha = 0.5;
			time.x = 160;
			time.y = 0;
			//time.y = -530;
			TweenLite.fromTo(time,10,{y:0}, {y:-530});
			this.addChild(time);
			
			bg = new Image(Assets.getTexture("BgGamePlay"));
			this.addChild(bg);
			
			var lobao:Lobao = new Lobao();
			this.addChild(lobao);
			lobao.gotoAndPlay("inicio");
			
			sheep_1 = new Sheep();
			this.addChild(sheep_1);
			
		}
		
		public function initialize():void {
			this.visible = true;
		}
		
		public function disposeTemporarily():void {
			this.visible = false;
		}
	}
}