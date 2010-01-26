package br.com.optimedia.xmppfc.model {
	import br.com.optimedia.xmppfc.controller.*;
	import br.com.optimedia.xmppfc.model.proxy.*;
	import br.com.optimedia.xmppfc.view.api.mediators.IXmppFcMediator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.jivesoftware.xiff.core.JID;
	import org.jivesoftware.xiff.data.Message;
	import org.jivesoftware.xiff.data.im.RosterItemVO;
	import org.jivesoftware.xiff.im.Roster;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	//import org.puremvc.as3.multicore.interfaces.INotification;
	//import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
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
		
		public static const SUBSCRIPTION_DENIAL:String = "subscripyin_denial";
		public static const SUBSCRIPTION_REQUEST:String = "subscripyin_request";
		public static const SUBSCRIPTION_REVOCATION:String = "subscripyin_revocation";
		
		private static var instanceXmppfcFacade: XmppfcFacade;
		
		public function XmppfcFacade(key: String) {
			super(key);
		}
		
		public static function getInstance(): XmppfcFacade {
			var key: String = "XmppfcFacade";
			if (instanceMap[ key ] == null) {
				instanceMap[ key ] = new XmppfcFacade(key);
				instanceMap[ key ].registerProxy(new XMPPProxy());
			} 
			return instanceMap[ key ] as XmppfcFacade;
		}
		
		private function get xmppProxy(): XMPPProxy {
			return retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
		}

		public function set mainMediator (xmppfcMediator: IXmppFcMediator):void {
			registerMediator(xmppfcMediator);
		}
		
		// Register commands with the controller
		override protected function initializeController():void {
			super.initializeController();
			
			
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
		
		public function getRosterDataProvider(): ArrayCollection {
			return xmppProxy.getRosterDataProvider();
		}
		
		public function sendMessage(jid: JID, msgTxt: String):void {
			var message:Message = new Message(jid, null, msgTxt, null, Message.CHAT_TYPE);
			return xmppProxy.sendMessage(message);
		}
		public function addContact (contactTxt: String, nickname: String = null, group: String = null):void {
			xmppProxy.addContact(contactTxt,nickname,group);

		}
		public function removeContact (vo:RosterItemVO):void{
			xmppProxy.removeContact(vo);
		}
	}
	
}