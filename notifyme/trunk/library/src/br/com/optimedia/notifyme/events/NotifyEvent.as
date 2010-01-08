package br.com.optimedia.notifyme.events
{
	import br.com.optimedia.notifyme.NotifymeFacade;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;

	public class NotifyEvent extends BaseGotoEvent
	{
		public var vo: NotificationVO;
		public function NotifyEvent(vo: NotificationVO, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(NotifymeFacade.NOTIFY, vo, bubbles, cancelable);
		}
	}
}