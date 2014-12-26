package utils
{
	public class RandomUtil
	{
		public function RandomUtil()
		{
		}
		
		public static function generateRandomNumbers(min:Number, max:Number):Array {
			if(min > max) {
				return null;
			}
			var arr:Array = new Array();;
			for(var i:Number = min; i<=max; i++) {
				arr.push(i);
			}
			
			return arr.sort(customSort);
		}
		
		private static function customSort(a:*, b:*):Boolean {
			if(Math.random() > 0.5)
				return false;
			else 
				return true;
		}
		
		public static function randomSort(value:Array):Array {
			return value.sort(customSort);
		}
		
		private function generateRandomNumber():void {
			/*var obj:Object = new Object();
			obj.numLeft = Math.abs(Math.random()*maxNum - minNum);
			obj.numRight = Math.abs(Math.random()*maxNum - minNum);
			return obj;*/
		}
	}
}