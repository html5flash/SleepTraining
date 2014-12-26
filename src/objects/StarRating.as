package objects
{
	import flash.events.Event;
	
	import model.ApplicationConst;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	
	public class StarRating extends Sprite
	{
		private var star_1:Star;
		private var star_2:Star;
		private var star_3:Star;
		private var star_4:Star;
		private var star_5:Star;
		
		public function StarRating()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:starling.events.Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createArt();
		}
		
		public function initialize(value:Number):void {
			var rating:Number = (value/ApplicationConst.MAX_LIMIT)*100;
			rating = rating / 20;
			
			if(rating >= 1) {
				star_1.initialize(2);
			} else if(rating > 0.5) {
				star_1.initialize(1);
			} else {
				star_1.initialize(0);
			}
			
			if(rating >= 2) {
				star_2.initialize(2);
			} else if(rating > 1.5) {
				star_2.initialize(1);
			} else {
				star_2.initialize(0);
			}
			
			if(rating >= 3) {
				star_3.initialize(2);
			} else if(rating > 2.5) {
				star_3.initialize(1);
			} else {
				star_3.initialize(0);
			}
			
			if(rating >= 4) {
				star_4.initialize(2);
			} else if(rating > 3.5) {
				star_4.initialize(1);
			} else {
				star_4.initialize(0);
			}
			
			if(rating >= 5) {
				star_5.initialize(2);
			} else if(rating > 4.5) {
				star_5.initialize(1);
			} else {
				star_5.initialize(0);
			}
		}
		
		private function createArt():void {
			star_1 = new Star();
			star_1.x = 0;			
			this.addChild(star_1);
			
			star_2 = new Star();
			star_2.x = star_1.x + star_1.width + 5;			
			this.addChild(star_2);
			
			star_3 = new Star();
			star_3.x = star_2.x + star_2.width + 5;			
			this.addChild(star_3);
			
			star_4 = new Star();
			star_4.x = star_3.x + star_3.width + 5;			
			this.addChild(star_4);
			
			star_5 = new Star();
			star_5.x = star_4.x + star_4.width + 5;			
			this.addChild(star_5);
		}
	}
}