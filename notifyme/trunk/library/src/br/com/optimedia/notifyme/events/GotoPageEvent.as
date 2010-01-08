package br.com.optimedia.notifyme.events
{
	import br.com.optimedia.notifyme.NotifymeFacade;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;

	public class GotoPageEvent extends BaseGotoEvent
	{
		public function GotoPageEvent(vo: NotificationVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(NotifymeFacade.GOTO_PAGE, vo, bubbles, cancelable);
		}
		
	}
}