package br.com.optimedia.notifyme.controller
{
	import br.com.optimedia.notifyme.model.proxy.NotifymeProxy;
	import br.com.optimedia.notifyme.view.api.mediators.INotifymeMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartupCommand extends SimpleCommand {
		
		private var notifymeProxy: NotifymeProxy; 
		
		public function StartupCommand() {
		}
		
		override public function execute(notification:INotification):void {
			notifymeProxy = new NotifymeProxy();
			
			facade.registerProxy(notifymeProxy);
	
			facade.registerMediator(notification.getBody() as INotifymeMediator);
			notifymeProxy.gotoFirst();
		}
	

	}
}