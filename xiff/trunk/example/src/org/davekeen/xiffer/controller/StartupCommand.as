/*
Macro Command - PureMVC
 */
package org.davekeen.xiffer.controller {
	import flash.display.DisplayObjectContainer;
	import org.davekeen.xiffer.Application;
	import org.davekeen.xiffer.model.XMPPProxy;
	import org.davekeen.xiffer.view.ApplicationMediator;
	import org.davekeen.xiffer.view.ChatMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * Startup command
	 */
	public class StartupCommand extends SimpleCommand {
	
		/**
		 * Initialize the model and views
		 */
		override public function execute(notification:INotification):void {
			facade.registerProxy(new XMPPProxy());
			
			facade.registerMediator(new ApplicationMediator(notification.getBody() as Application));
		}
		
	}
}
