package br.com.optimedia.notifyme.events
{
	import br.com.optimedia.notifyme.NotifymeFacade;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;

	public class GotoNextEvent extends BaseGotoEvent
	{
		public function GotoNextEvent(vo: NotificationVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(NotifymeFacade.GOTO_NEXT, vo, bubbles, cancelable);
		}
		
	}
}