package events
{
	import starling.events.Event;
	
	public class SheepEvent extends Event
	{
		public static const FEEDBACK:String = "feedback";
		public static const FEEDBACK_COMPLETE:String = "feedback_complete";
		
		public var params:Object;
		public function SheepEvent(type:String, paramsObj:Object = null, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
			params = paramsObj;
		}
	}
}