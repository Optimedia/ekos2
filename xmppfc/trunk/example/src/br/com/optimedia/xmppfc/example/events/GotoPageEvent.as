package br.com.optimedia.xmppfc.example.events
{
	import flash.events.Event;

	public class GotoPageEvent extends Event
	{
		public function GotoPageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}