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
		
		[Embed(source="../media/sounds/1.mp3")] 
		public static const Sound_1:Class;
		
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