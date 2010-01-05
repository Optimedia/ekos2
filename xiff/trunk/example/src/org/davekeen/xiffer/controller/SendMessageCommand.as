/*
Simple Command - PureMVC
 */
package org.davekeen.xiffer.controller {
	import org.davekeen.xiffer.events.ChatEvent;
	import org.davekeen.xiffer.model.XMPPProxy;
	import org.jivesoftware.xiff.data.Message;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
	/**
	 * Send a message to the proxy
	 */
	public class SendMessageCommand extends SimpleCommand {
		
		override public function execute(note:INotification):void {
			var message:Message = note.getBody() as Message;
			var xmppProxy:XMPPProxy = facade.retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
			
			// Send the message
			xmppProxy.sendMessage(message);
		}
		
	}
}