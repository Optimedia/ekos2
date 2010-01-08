package br.com.optimedia.notifyme.events
{
	import br.com.optimedia.notifyme.NotifymeFacade;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	
	import flash.events.Event;

	public class GotoFirstEvent extends BaseGotoEvent
	{
		public function GotoFirstEvent(vo: NotificationVO, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(NotifymeFacade.GOTO_FIRST, vo, bubbles, cancelable);
		}
	}
}