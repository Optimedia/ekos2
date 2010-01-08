package br.com.optimedia.notifyme.events
{
	import br.com.optimedia.notifyme.NotifymeFacade;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;

	public class GotoListEvent extends BaseGotoEvent
	{
		public function GotoListEvent(vo: NotificationVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(NotifymeFacade.GOTO_LIST, vo, bubbles, cancelable);
		}
		
	}
}