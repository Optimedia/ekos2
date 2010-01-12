package br.com.optimedia.xmppfc {
	import br.com.optimedia.xmppfc.controller.*;
	import br.com.optimedia.xmppfc.model.*;
	import br.com.optimedia.xmppfc.view.*;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.jivesoftware.xiff.data.Message;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	/**
	* ...
	* @author Dave Keen
	*/
	public class XmppfcFacade extends Facade implements IFacade {
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
		
		private static var instanceXmppfcFacade: XmppfcFacade;
		
		public function XmppfcFacade(key: String) {
			super(key);
		}
		
		public static function getInstance(): XmppfcFacade {
			var key: String = "XmppfcFacade";
			if (instanceMap[ key ] == null) instanceMap[ key ] = new XmppfcFacade(key);
			return instanceMap[ key ] as XmppfcFacade;
		}
		
		private function get xmppProxy(): XMPPProxy {
			return retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
		}
		
		// Register commands with the controller
		override protected function initializeController():void {
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
			
			/*
			registerCommand(LOGIN, LoginCommand);
			registerCommand(LOGOUT, LogoutCommand);
			
			registerCommand(SEND_MESSAGE, SendMessageCommand);
			*/
		}
		
		// Abstract
		public function emitSecurityAlert(securityMessage: String): void {
			Alert.show(securityMessage);
		}
		
		public function connect(user: String, password: String, server: String): void {
			xmppProxy.connect(user, password, server);
		}

		public function disconnect():void {
			xmppProxy.disconnect();
		}
		
		public function getRosterDataProvider():ArrayCollection {
			return xmppProxy.getRosterDataProvider();
		}
		
		public function sendMessage(message:Message):void {
			return xmppProxy.sendMessage(message);
		}
		
	}
	
}