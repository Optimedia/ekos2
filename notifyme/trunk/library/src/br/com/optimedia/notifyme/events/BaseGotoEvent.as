package br.com.optimedia.notifyme.events
{
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	
	import flash.events.Event;

	public class BaseGotoEvent extends Event
	{
		public var notificationVO: NotificationVO;
		
		public function BaseGotoEvent(type: String, vo: NotificationVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.notificationVO = vo;
		}
	}
}