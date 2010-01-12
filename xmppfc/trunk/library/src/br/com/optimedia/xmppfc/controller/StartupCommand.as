/*
Macro Command - PureMVC
 */
package br.com.optimedia.xmppfc.controller {
	import br.com.optimedia.xmppfc.model.XMPPProxy;
	import br.com.optimedia.xmppfc.view.api.mediators.IXmppFcMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	/**
	 * Startup command
	 */
	public class StartupCommand extends SimpleCommand {
	
		/**
		 * Initialize the model and views
		 */
		override public function execute(notification:INotification):void {
			facade.registerProxy(new XMPPProxy());
			
			//facade.registerMediator(new ApplicationMediator(notification.getBody()));
			facade.registerMediator(notification.getBody() as IXmppFcMediator);
		}
		
	}
}
