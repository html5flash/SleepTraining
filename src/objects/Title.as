package objects
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Title extends Sprite
	{
		private var titleArt:Image;
		private var titleBg:Image;
		public function Title()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createTitleArt();
		}
		
		private function createTitleArt():void {
			titleBg = new Image(Assets.getAtlas("title").getTexture("nuvem_TI"));
			titleBg.x = Math.ceil(-titleBg.width/2) + 10;
			titleBg.y = Math.ceil(-titleBg.height/2) - 30;
			this.addChild(titleBg);
			
			titleArt = new Image(Assets.getAtlas("title").getTexture("titulo"));
			titleArt.x = Math.ceil(-titleArt.width/2);
			titleArt.y = Math.ceil(-titleArt.height/2) - 50;
			this.addChild(titleArt);
		}
	}
}