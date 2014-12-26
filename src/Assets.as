package
{
	import dragonBones.Armature;
	import dragonBones.factorys.StarlingFactory;
	import dragonBones.objects.SkeletonData;
	import dragonBones.objects.XMLDataParser;
	import dragonBones.textures.StarlingTextureAtlas;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.Font;
	import flash.utils.Dictionary;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		[Embed(source="../media/graphics/BG_homescreem.png")]
		public static const BgWelcome:Class;
		
		[Embed(source="../media/graphics/BG_gameplay.png")]
		public static const BgGamePlay:Class;
		
		[Embed(source="../media/graphics/time.png")]
		public static const Time:Class;
		
		[Embed(source="../media/graphics/play_again_button.png")]
		public static const ReplayButton:Class;
		
		[Embed(source="../media/graphics/stars/star_full.png")]
		public static const Star_Full:Class;
		
		[Embed(source="../media/graphics/stars/star_half.png")]
		public static const Star_Half:Class;
		
		[Embed(source="../media/graphics/stars/star_none.png")]
		public static const Star_None:Class;
		
		[Embed(source="../media/graphics/title/texture.png")]
		public static const AtlasTextureTitle:Class;
		
		[Embed(source="../media/graphics/title/texture.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlTitle:Class;
		
		[Embed(source="../media/graphics/title/skeleton.xml", mimeType="application/octet-stream")]
		public static const SkeletonXmlTitle:Class;
		
		[Embed(source="../media/graphics/playButton/texture.png")]
		public static const AtlasTexturePlayBtn:Class;
		
		[Embed(source="../media/graphics/playButton/texture.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlPlayBtn:Class;
		
		[Embed(source="../media/graphics/playButton/skeleton.xml", mimeType="application/octet-stream")]
		public static const SkeletonXmlPlayBtn:Class;
		
		[Embed(source="../media/graphics/sheep/texture.png")]
		public static const AtlasTextureSheep:Class;
		
		[Embed(source="../media/graphics/sheep/texture.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlSheep:Class;
		
		[Embed(source="../media/graphics/sheep/skeleton.xml", mimeType="application/octet-stream")]
		public static const SkeletonXmlSheep:Class;
		
		[Embed(source="../media/graphics/lobao/texture.png")]
		public static const AtlasTextureLobao:Class;
		
		[Embed(source="../media/graphics/lobao/texture.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlLobao:Class;
		
		[Embed(source="../media/graphics/lobao/skeleton.xml", mimeType="application/octet-stream")]
		public static const SkeletonXmlLobao:Class;
		
		[Embed(source="../media/fonts/font.fnt", mimeType="application/octet-stream")]
		public static const FontXML:Class;
		
		[Embed(source="../media/fonts/font.png")]
		public static const FontTexture:Class;
		
		[Embed(source="../media/sounds/background.mp3")] 
		public static const Sound_Background:Class; 
		
		[Embed(source="../media/sounds/hello_guys.mp3")] 
		public static const Sound_Hello:Class;
		
		[Embed(source="../media/sounds/feedback_correct.mp3")] 
		public static const Sound_Feedback_Correct:Class;
		
		[Embed(source="../media/sounds/feedback_incorrect.mp3")]
		public static const Sound_Feedback_Incorrect:Class;
		
		[Embed(source="../media/sounds/chocking_snoring.mp3")]
		public static const Sound_Chocking_Snoring:Class;
		
		[Embed(source="../media/sounds/deep_sleep.mp3")]
		public static const Sound_Deep_Sleep:Class;
		
		[Embed(source="../media/sounds/long_yawn.mp3")]
		public static const Sound_Long_Yawn:Class;
		
		[Embed(source="../media/sounds/scared.mp3")]
		public static const Sound_Scared:Class;
		
		[Embed(source="../media/sounds/sleepy_voice.mp3")]
		public static const Sound_Sleepy_Voice:Class;
		
		[Embed(source="../media/sounds/snore_whistle.mp3")]
		public static const Sound_Snore_Whistle:Class;
		
		[Embed(source="../media/sounds/snoring_chocking_coughing.mp3")]
		public static const Sound_Snoring_Chocking_Coughing:Class;
		
		[Embed(source="../media/sounds/waking_up_scared.mp3")]
		public static const Sound_Waking_Up_Scared:Class;
		
		[Embed(source="../media/sounds/1.mp3")] 
		public static const Sound_1:Class;
		
		[Embed(source="../media/sounds/2.mp3")] 
		public static const Sound_2:Class;
		
		[Embed(source="../media/sounds/3.mp3")] 
		public static const Sound_3:Class;
		
		[Embed(source="../media/sounds/4.mp3")] 
		public static const Sound_4:Class;
		
		[Embed(source="../media/sounds/5.mp3")] 
		public static const Sound_5:Class;
		
		[Embed(source="../media/sounds/6.mp3")] 
		public static const Sound_6:Class;
		
		[Embed(source="../media/sounds/7.mp3")] 
		public static const Sound_7:Class;
		
		[Embed(source="../media/sounds/8.mp3")] 
		public static const Sound_8:Class;
		
		[Embed(source="../media/sounds/9.mp3")] 
		public static const Sound_9:Class;
		
		[Embed(source="../media/sounds/10.mp3")] 
		public static const Sound_10:Class;
		
		[Embed(source="../media/sounds/11.mp3")] 
		public static const Sound_11:Class;
		
		[Embed(source="../media/sounds/12.mp3")] 
		public static const Sound_12:Class;
		
		[Embed(source="../media/sounds/13.mp3")] 
		public static const Sound_13:Class;
		
		[Embed(source="../media/sounds/14.mp3")] 
		public static const Sound_14:Class;
		
		[Embed(source="../media/sounds/15.mp3")] 
		public static const Sound_15:Class;
		
		public static var myFont:BitmapFont;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var titleTextureAtlas:StarlingTextureAtlas;
		private static var playBtnTextureAtlas:StarlingTextureAtlas;
		private static var sheepTextureAtlas:StarlingTextureAtlas;
		private static var lobaoTextureAtlas:StarlingTextureAtlas;
		
		private static var skeletonData:SkeletonData;
		public static function getFont():BitmapFont {
			var fontTexture:Texture = Texture.fromBitmap(new FontTexture());
			var fontXML:XML = XML(new FontXML());
			var font:BitmapFont = new BitmapFont(fontTexture, fontXML);
			TextField.registerBitmapFont(font);
			return font;
		}
		
		public static function getTexture(name:String):Texture {
			if(gameTextures[name] == undefined) {
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);				
			}
			return gameTextures[name];
		}
		
		public static function getAtlas(atlasName:String):* {
			var texture:Texture;
			var xml:XML;
			switch(atlasName) {
				case "title":
					if(titleTextureAtlas == null) {
						texture = getTexture("AtlasTextureTitle");
						xml = XML(new AtlasXmlTitle());
						titleTextureAtlas = new StarlingTextureAtlas(texture, xml);
					}
					
					return titleTextureAtlas;
					break;
				case "playBtn":
					if(playBtnTextureAtlas == null) {
						texture = getTexture("AtlasTexturePlayBtn");
						xml = XML(new AtlasXmlPlayBtn());
						playBtnTextureAtlas = new StarlingTextureAtlas(texture, xml);
					}
					
					return playBtnTextureAtlas;
					break;
				case "sheep":
					if(sheepTextureAtlas == null) {
						texture = getTexture("AtlasTextureSheep");
						xml = XML(new AtlasXmlSheep());
						sheepTextureAtlas = new StarlingTextureAtlas(texture, xml);
					}
					
					return sheepTextureAtlas;
					break;
				case "lobao":
					if(lobaoTextureAtlas == null) {
						texture = getTexture("AtlasTextureLobao");
						xml = XML(new AtlasXmlLobao());
						lobaoTextureAtlas = new StarlingTextureAtlas(texture, xml, true);
					}
					
					return lobaoTextureAtlas;
					break;
			}
			return null;
		}
		
		public static function getSkeleton(name:String):XML {			
			var xml:XML;
			switch(name) {
				case "title":
					xml = XML(new SkeletonXmlTitle());					
					break;
				case "playBtn":
					xml = XML(new SkeletonXmlPlayBtn());
					break;
				case "sheep":
					xml = XML(new SkeletonXmlSheep());
					break;
				case "lobao":
					xml = XML(new SkeletonXmlLobao());
					break;
			}
			return xml;
		}
		
		public static function getArmature(name:String):Armature {
			var armature:Armature;
			var skeletonXml:XML;
			var skeletonData:SkeletonData;
			var textureAtlas:StarlingTextureAtlas;
			var factory:StarlingFactory;
			switch(name) {
				case "title":
					skeletonData = XMLDataParser.parseSkeletonData(XML(getSkeleton(name)));
					textureAtlas = Assets.getAtlas(name);
					factory = new StarlingFactory();
					factory.addSkeletonData(skeletonData, name);
					factory.addTextureAtlas(textureAtlas, name);
					armature = factory.buildArmature("titulo_mov");					
					break;
				case "playBtn":
					skeletonData = XMLDataParser.parseSkeletonData(XML(getSkeleton(name)));
					textureAtlas = Assets.getAtlas(name);
					factory = new StarlingFactory();
					factory.addSkeletonData(skeletonData, name);
					factory.addTextureAtlas(textureAtlas, name);
					armature = factory.buildArmature("btn_play");
					break;
				case "sheep":
					skeletonData = XMLDataParser.parseSkeletonData(XML(getSkeleton(name)));
					textureAtlas = Assets.getAtlas(name);
					factory = new StarlingFactory();
					factory.addSkeletonData(skeletonData, name);
					factory.addTextureAtlas(textureAtlas, name);
					armature = factory.buildArmature("ovelha");
					break;
				case "lobao":
					skeletonData = XMLDataParser.parseSkeletonData(XML(getSkeleton(name)));
					textureAtlas = Assets.getAtlas(name);
					factory = new StarlingFactory();
					factory.addSkeletonData(skeletonData, name);
					factory.addTextureAtlas(textureAtlas, name);
					armature = factory.buildArmature("cabeca_lobao_sono");
					break;
			}
			return armature;
		}
	}
}