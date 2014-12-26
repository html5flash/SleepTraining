package objects
{
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
	import dragonBones.events.AnimationEvent;
	import dragonBones.factorys.StarlingFactory;
	import dragonBones.objects.ObjectDataParser;
	import dragonBones.objects.SkeletonData;
	import dragonBones.objects.XMLDataParser;
	import dragonBones.textures.StarlingTextureAtlas;
	import dragonBones.utils.parseOldXMLData;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.textures.Texture;
	
	
	
	public class Lobao extends Sprite
	{
		private var factory:StarlingFactory;
		private var armatures:Array;
		private var armature:Armature;
		
		// Scene Objects
		private var sceneRoot:Sprite;
		public function Lobao()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createTitleArt();
		}
		
		private function createTitleArt():void {
			var name:String = "lobao";
			armature = Assets.getArmature(name);			
			armature.display.x = 389;
			armature.display.y = 238;
			this.addChild(armature.display as Sprite);
			armature.addEventListener(AnimationEvent.COMPLETE, animationCompleteHandler);
			//armature.animation.gotoAndPlay("inicio");//begin
			//armature.animation.gotoAndPlay("dormindo");//sleeping
			armature.animation.gotoAndPlay("lobao_acordando");//lobao waking
			//armature.animation.gotoAndPlay("acordando_zoado");//waking messed up
			//armature.animation.gotoAndPlay("acordando_bem");//waking up well
			WorldClock.clock.add(armature);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
		}
		
		public function gotoAndPlay(name:String):void {
			trace("armature.animation.movementID:" + armature.animation.movementID);
		}
		
		private function onEnterFrameHandler(evt:EnterFrameEvent):void
		{
			WorldClock.clock.advanceTime(-1);
			//armature.advanceTime(1 / 30);
		}
		
		private function animationCompleteHandler(event:AnimationEvent):void {
			switch(armature.animation.movementID) {
				case "inicio":
					armature.animation.gotoAndPlay("dormindo");
					break;
				case "lobao_acordando":
					//armature.animation.gotoAndPlay("lobao_acordando");
					break;
				case "acordando_zoado":
					armature.animation.gotoAndPlay("acordando_zoado");
					break;
				case "acordando_bem":
					//armature.animation.gotoAndPlay("acordando_bem");
					break;
			}
		}
	}
}