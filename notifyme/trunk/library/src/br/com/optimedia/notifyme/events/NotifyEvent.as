package br.com.optimedia.notifyme.events
{
	import br.com.optimedia.notifyme.model.NotifymeFacade;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	
	import flash.events.Event;

	public class NotifyEvent extends Event
	{
		public var vo: NotificationVO;
		public function NotifyEvent(vo: NotificationVO, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(NotifymeFacade.NOTIFY, bubbles, cancelable);
			this.vo = vo;
		}
	}
}