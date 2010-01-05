package org.davekeen.xiffer {
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.davekeen.xiffer.model.*;
	import org.davekeen.xiffer.view.*;
	import org.davekeen.xiffer.controller.*;
	
	/**
	* ...
	* @author Dave Keen
	*/
	public class ApplicationFacade extends Facade implements IFacade {
		// Notification name constants
		public static const STARTUP:String = "startup";
		
		public static const LOGIN:String = "login";
		public static const LOGOUT:String = "logout";
		
		public static const VALID_LOGIN:String = "valid_login";
		public static const INVALID_LOGIN:String = "invalid_login";
		public static const DISCONNECT:String = "disconnect";
		public static const SECURITY_ERROR:String = "security_error";
		
		public static const SEND_MESSAGE:String = "send_message";
		public static const RECEIVE_MESSAGE:String = "receive_message";
		
		public static const OPEN_CHAT_WINDOW:String = "open_chat_window";
		
		public static function getInstance():ApplicationFacade {
			if (instance == null) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		
		// Register commands with the controller
		override protected function initializeController():void {
			super.initializeController();
			
			registerCommand(STARTUP, StartupCommand);
			
			registerCommand(LOGIN, LoginCommand);
			registerCommand(LOGOUT, LogoutCommand);
			
			registerCommand(SEND_MESSAGE, SendMessageCommand);
		}
		
	}
	
}