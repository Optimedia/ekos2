﻿/*
Simple Command - PureMVC
 */
package br.com.optimedia.xmppfc.controller {
	import br.com.optimedia.xmppfc.model.XMPPProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.patterns.observer.Notification;
    
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