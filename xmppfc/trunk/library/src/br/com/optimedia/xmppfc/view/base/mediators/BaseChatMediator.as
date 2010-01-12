package br.com.optimedia.xmppfc.view.base.mediators
{
	
	import br.com.optimedia.xmppfc.XmppfcFacade;
	import br.com.optimedia.xmppfc.events.ChatEvent;
	import br.com.optimedia.xmppfc.view.api.components.IChatView;
	import br.com.optimedia.xmppfc.view.api.mediators.IChatMediator;
	import br.com.optimedia.xmppfc.view.base.components.BaseChatView;
	
	import flash.events.Event;
	
	import mx.core.Application;
	import mx.managers.PopUpManager;
	
	import org.jivesoftware.xiff.core.JID;
	import org.jivesoftware.xiff.data.Message;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	
	public class BaseChatMediator extends Mediator implements IChatMediator {

		public static const NAME:String = "XmppFcChatMediator";

		private var chatViews: Array;

		public function BaseChatMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			this.initializeNotifier("XmppfcFacade");
			chatViews = new Array();
		}
		
		// overrides
		override public function getMediatorName():String {
			return NAME;
		}

		public function get chatView(): IChatView {
			return viewComponent as IChatView;
		}

		override public function listNotificationInterests():Array {
			return [
						XmppfcFacade.OPEN_CHAT_WINDOW,
						XmppfcFacade.RECEIVE_MESSAGE,
						XmppfcFacade.VALID_LOGIN,
						XmppfcFacade.DISCONNECT
					];
		}

		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {
				case XmppfcFacade.OPEN_CHAT_WINDOW:
					onOpenChatWindow(note);
					break;
				case XmppfcFacade.RECEIVE_MESSAGE:
					onReceiveMessage(note);
					break;
				case XmppfcFacade.VALID_LOGIN:
					onValidLogin(note);
					break;
				case XmppfcFacade.DISCONNECT:
					onDisconnect(note);
					break;
				default:
					break;		
			}
		}

		public function onOpenChatWindow(note:INotification): void {
			var jid:JID = note.getBody() as JID;
			showChatWindow(jid);
		}

		public function onReceiveMessage(note:INotification): void {
			var message:Message = note.getBody() as Message;
			
			//var chatView:* = chatViews[message.from.toBareJID()];
			if (message.type) {
				if (message.body) {
					var chatView:* = showChatWindow(message.from);
					//chatView.isUserTyping(false);
					chatView.addMessage(message);						
				} else {
					//chatView.isUserTyping(true);
				}
			}
		}

		public function onValidLogin(note:INotification): void {
			for each (var chatView:IChatView in chatViews)
				chatView.enabled = true;
		}

		public function onDisconnect(note:INotification): void {
			for each (var chatView: IChatView in chatViews)
				chatView.enabled = false;
		}

		public function showChatWindow(jid:JID): IChatView {
			// If the window exists already don't do anything
			if (!chatViews[jid.toBareJID()]) {
				var chatView:IChatView = newChatView();
				
				PopUpManager.addPopUp(chatView, Application.application.chatArea, false);
				PopUpManager.bringToFront(chatView);
				PopUpManager.centerPopUp(chatView);
				
				chatView.addEventListener(Event.CLOSE, onChatViewClose);
				chatView.addEventListener(ChatEvent.SEND_MESSAGE, onSendMessage);
				chatView.setJID(jid);
				
				// Add the chat view to the associative array
				chatViews[jid.toBareJID()] = chatView;
			}
			return chatViews[jid.toBareJID()];
		}
		
		public function onSendMessage(chatEvent: ChatEvent): void {
			var chatView:IChatView = chatEvent.currentTarget as IChatView;
			var message:Message = new Message(chatEvent.getJID(), null, chatEvent.getMessage(), null, Message.CHAT_TYPE);
			chatViews[chatView.getJID().toBareJID()].addMessage(message);
			sendNotification(XmppfcFacade.SEND_MESSAGE, message);
		}
		
		public function onChatViewClose(event: Event): void {
			var chatView:IChatView = event.currentTarget as IChatView;
			chatView.removeEventListener(Event.CLOSE, onChatViewClose);
			PopUpManager.removePopUp(chatView);
			delete chatViews[chatView.getJID().toBareJID()];
		}
		
		// abstract
		protected function newChatView(): IChatView {
			return new BaseChatView();
		}

	}
}