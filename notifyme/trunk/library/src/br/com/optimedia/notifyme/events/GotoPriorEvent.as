package br.com.optimedia.notifyme.events
{
	import br.com.optimedia.notifyme.NotifymeFacade;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;

	public class GotoPriorEvent extends BaseGotoEvent
	{
		public function GotoPriorEvent(vo: NotificationVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(NotifymeFacade.GOTO_PRIOR, vo, bubbles, cancelable);
		}
		
	}
}