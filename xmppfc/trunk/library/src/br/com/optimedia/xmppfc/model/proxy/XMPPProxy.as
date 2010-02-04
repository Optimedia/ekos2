package br.com.optimedia.xmppfc.model.proxy {
	import br.com.optimedia.xmppfc.model.XmppfcFacade;
	
	import mx.collections.ArrayCollection;
	
	import org.jivesoftware.xiff.core.JID;
	import org.jivesoftware.xiff.core.XMPPSocketConnection;
	import org.jivesoftware.xiff.data.Message;
	import org.jivesoftware.xiff.data.Presence;
	import org.jivesoftware.xiff.data.im.RosterItemVO;
	import org.jivesoftware.xiff.events.DisconnectionEvent;
	import org.jivesoftware.xiff.events.LoginEvent;
	import org.jivesoftware.xiff.events.MessageEvent;
	import org.jivesoftware.xiff.events.RosterEvent;
	import org.jivesoftware.xiff.events.XIFFErrorEvent;
	import org.jivesoftware.xiff.im.Roster;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	/**
	 * Proxy to XMPP server
	 */
	public class XMPPProxy extends Proxy implements IProxy {
		
		public static const NAME:String = "XMPPProxy";
		
		private var xmppSocketConnection:XMPPSocketConnection;
		private var roster:Roster;

		public function XMPPProxy(data:Object = null) {
			super(NAME, data);
			
			setupConnection();
			configureListeners();
		}
		
		/**
		 * Create the required XMPP objects and do any configuration on them that we might require
		 */
		private function setupConnection():void {
			xmppSocketConnection = new XMPPSocketConnection();
			
			roster = new Roster();
			roster.connection = xmppSocketConnection;
		}
		
		private function configureListeners():void {
			// Add event listeners related to the connection
			xmppSocketConnection.addEventListener(LoginEvent.LOGIN, onLogin);
			xmppSocketConnection.addEventListener(XIFFErrorEvent.XIFF_ERROR, onXiffError);
			xmppSocketConnection.addEventListener(DisconnectionEvent.DISCONNECT, onDisconnect);
			
			// Add event listeners related to messages
			xmppSocketConnection.addEventListener(MessageEvent.MESSAGE, onMessage);
			
			// These events can be implemented in a future version of the application
			//xmppSocketConnection.addEventListener(OutgoingDataEvent.OUTGOING_DATA, onOutgoingData)
			//xmppSocketConnection.addEventListener(IncomingDataEvent.INCOMING_DATA, onIncomingData);
			//xmppSocketConnection.addEventListener(RegistrationSuccessEvent.REGISTRATION_SUCCESS, onRegistrationSuccess);
			
			// Add event listeners related to the roster
			roster.addEventListener(RosterEvent.SUBSCRIPTION_DENIAL, 		subscriptionDenial);
			roster.addEventListener(RosterEvent.SUBSCRIPTION_REQUEST, 		subscriptionRequest);
			roster.addEventListener(RosterEvent.SUBSCRIPTION_REVOCATION, 	subscriptionRevocation);
			//	roster.addEventListener(RosterEvent.USER_AVAILABLE, 			userAvailable);
			//	roster.addEventListener(RosterEvent.USER_UNAVAILABLE, 			userUnavailable);
			
			// Add event listeners related to presence
			//xmppSocketConnection.addEventListener(PresenceEvent.PRESENCE, presenceHandler);
		}
		
		/**
		 * Attempt to connect to a XMPP server
		 * 
		 * @param	username
		 * @param	password
		 * @param	server
		 */
		public function connect(username:String, password:String, server:String):void {
			// Attempt to load a crossdomain permissions file
			//Security.loadPolicyFile(server + "/crossdomain.xml");
			
			// Connect using standard profile
			xmppSocketConnection.username = username;
			xmppSocketConnection.password = password;
			xmppSocketConnection.server = server;
			xmppSocketConnection.connect("standard");
		}
		
		/**
		 * Disconnect from a XMPP server.  If not currently connected this will have no effect.
		 * 
		 */
		public function disconnect():void {
			xmppSocketConnection.disconnect();
		}
		
		/**
		 * Return the roster as a data provider
		 * 
		 * @return
		 */
		public function getRosterDataProvider():ArrayCollection {
			return roster;
		}
		
		/**
		 * Send a message to the server
		 * 
		 * @param	message
		 */
		public function sendMessage(message:Message):void {
			xmppSocketConnection.send(message);
		}
		
		/**
		 * The user has successfully logged on to the XMPP server
		 * 
		 * @param	connectionSuccessEvent
		 */
		private function onLogin(loginEvent:LoginEvent):void {
			roster.setPresence(Presence.SHOW_CHAT, "", 0);
			
			sendNotification(XmppfcFacade.VALID_LOGIN);
		}
		
		/**
		 * There has been a Jabber error - most likely an incorrect username/password error
		 * 
		 * @param	xiffErrorEvent
		 */
		private function onXiffError(xiffErrorEvent:XIFFErrorEvent):void {
			switch (xiffErrorEvent.errorCode) {
				case 400:
					sendNotification(XmppfcFacade.INVALID_LOGIN);
					break;
				case 401:
					sendNotification(XmppfcFacade.SECURITY_ERROR, xiffErrorEvent.errorMessage);
					break;
				default:
					break;
			}
			
		}
		
		/**
		 * The user has disconnected from the XMPP server
		 * 
		 * @param	disconnectionEvent
		 */
		private function onDisconnect(disconnectionEvent:DisconnectionEvent):void {
			sendNotification(XmppfcFacade.DISCONNECT);
		}
		
		/**
		 * Received a message from the server
		 * 
		 * @param	messageEvent
		 */
		private function onMessage(messageEvent:MessageEvent):void {
			sendNotification(XmppfcFacade.RECEIVE_MESSAGE, messageEvent.data);
		}
		
		public function addContact(contact: String, nickname: String = null, group: String = null): void {
			var jid:JID = new JID(contact + "@" + "10.1.1.12");
			roster.addContact(jid,nickname,group);
		}
		public function removeContact(vo:RosterItemVO):void {
			roster.removeContact(vo);
		}
		public function grantSubscription(jid:JID):void {
			roster.grantSubscription(jid);
		}
		public function denySubscription(jid:JID):void {
			roster.denySubscription(jid);
		}
		
		
		public function subscriptionDenial(event:RosterEvent):void {
			sendNotification(XmppfcFacade.SUBSCRIPTION_DENIAL, event.jid);
			
		}		
		public function subscriptionRequest(event:RosterEvent):void {
			sendNotification(XmppfcFacade.SUBSCRIPTION_REQUEST, event.jid);
			
		}
		public function subscriptionRevocation (event:RosterEvent):void {
			sendNotification(XmppfcFacade.SUBSCRIPTION_REVOCATION, event.data);
			
		}
		public function jidExists (jid:JID):Boolean{
			//return true;
			return roster.contains(RosterItemVO.get(jid, false));
		}
		/*
		public function invite(event:InviteEvent):void {
			Alert.show("teste invide");
		}
		
		public function userAvailable(event:RosterEvent):void {
			sendNotification(XmppfcFacade.USER_AVAILABLE, event.jid);	
		}
		public function userUnavailable(event:RosterEvent):void {
			sendNotification(XmppfcFacade.USER_UNAVAILABLE, event.jid);
			
		}
		*/
	}
}