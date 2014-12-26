package objects
{
	import flash.events.Event;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	
	public class Star extends Sprite
	{
		private var star:Image;
		public function Star()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:starling.events.Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createArt();
		}
		
		public function initialize(value:Number):void {
			var texture:Texture;
			this.visible = true;
			if(star) {
				//this.removeChild(star);
			}
			switch(value) {
				case 0:
					texture = Assets.getTexture("Star_None");
					break;
				case 1:
					texture = Assets.getTexture("Star_Half");
					break;
				case 2:
					texture = Assets.getTexture("Star_Full");
					break;
			}
			//star = new Image(texture);
			star.texture = texture;
			//this.addChild(star);
		}
		
		private function createArt():void {
			star = new Image(Assets.getTexture("Star_None"));
			this.addChild(star);
		}
	}
}