package br.com.optimedia.notifyme.controller
{
	import br.com.optimedia.notifyme.events.BaseGotoEvent;
	import br.com.optimedia.notifyme.model.proxy.NotifymeProxy;
	import br.com.optimedia.notifyme.model.vo.NotificationVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class BaseGotoCommand extends SimpleCommand {
		
		public function get notifymeProxy(): NotifymeProxy {
			return facade.retrieveProxy(NotifymeProxy.NAME) as NotifymeProxy;
		}
		
		override public function execute(note:INotification):void {
			var vo: NotificationVO = note.getBody().notificationVO as NotificationVO;
			executeGoto(vo);
		}
		
		public function executeGoto(vo: NotificationVO): void {
			
		}
	}
}