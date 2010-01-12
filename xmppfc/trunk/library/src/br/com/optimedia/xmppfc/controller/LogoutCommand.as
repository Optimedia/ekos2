/*
Simple Command - PureMVC
 */
package br.com.optimedia.xmppfc.controller {
	import br.com.optimedia.xmppfc.model.XMPPProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
    
	/**
	 * Disconnect from the XMPP server
	 */
	public class LogoutCommand extends SimpleCommand {
		
		override public function execute(note:INotification):void {
			var xmppProxy:XMPPProxy = facade.retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
			
			xmppProxy.disconnect();
		}
		
	}
}