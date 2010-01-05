/*
Simple Command - PureMVC
 */
package org.davekeen.xiffer.controller {
	import org.davekeen.xiffer.events.LoginViewEvent;
	import org.davekeen.xiffer.model.XMPPProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * Login to the XMPP server with the details specified in the LoginViewEvent
	 */
	public class LoginCommand extends SimpleCommand {
		
		override public function execute(note:INotification):void {
			var loginViewEvent:LoginViewEvent = note.getBody() as LoginViewEvent;
			var xmppProxy:XMPPProxy = facade.retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
			
			xmppProxy.connect(loginViewEvent.getUsername(), loginViewEvent.getPassword(), loginViewEvent.getServer());
		}
		
	}
}