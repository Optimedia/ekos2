/*
 Mediator - PureMVC
 */
package br.com.optimedia.xmppfc.view {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import mx.managers.PopUpManager;
	import mx.managers.PopUpManagerChildList;
	import org.jivesoftware.xiff.core.JID;
	import org.jivesoftware.xiff.data.Message;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import br.com.optimedia.xmppfc.ApplicationFacade;
	import br.com.optimedia.xmppfc.events.ChatEvent;
	import br.com.optimedia.xmppfc.view.*;
	import br.com.optimedia.xmppfc.view.components_old.ChatView;
	
	/**
	 * Chat Mediator - controls and stewards all popup chat windows
	 */
	public class ChatMediator extends Mediator implements IMediator {
	
		// Cannonical name of the Mediator
		public static const NAME:String = "ChatMediator";
		
		/**
		 * An associative array of open ChatViews
		 */
		private var chatViews:Array;
		
		public function ChatMediator(viewComponent:Object) {
			// pass the viewComponent to the superclass where 
			// it will be stored in the inherited viewComponent property
			super(NAME, viewComponent);
			
			chatViews = new Array();
		}

		/**
		 * Get the Mediator name.
		 * <P>
		 * Called by the framework to get the name of this
		 * mediator. If there is only one instance, we may
		 * define it in a constant and return it here. If
		 * there are multiple instances, this method must
		 * return the unique name of this instance.</P>
		 * 
		 * @return String the Mediator name
		 */
		override public function getMediatorName():String {
			return ChatMediator.NAME;
		}
        
		/**
		 * List all notifications this Mediator is interested in.
		 * <P>
		 * Automatically called by the framework when the mediator
		 * is registered with the view.</P>
		 * 
		 * @return Array the list of Nofitication names
		 */
		override public function listNotificationInterests():Array {
			return [
					ApplicationFacade.OPEN_CHAT_WINDOW,
					ApplicationFacade.RECEIVE_MESSAGE,
					ApplicationFacade.VALID_LOGIN,
					ApplicationFacade.DISCONNECT
					];
		}

		/**
		 * Handle all notifications this Mediator is interested in.
		 * <P>
		 * Called by the framework when a notification is sent that
		 * this mediator expressed an interest in when registered
		 * (see <code>listNotificationInterests</code>.</P>
		 * 
		 * @param INotification a notification 
		 */
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {
				case ApplicationFacade.OPEN_CHAT_WINDOW:
					var jid:JID = note.getBody() as JID;
					showChatWindow(jid);
					break;
				case ApplicationFacade.RECEIVE_MESSAGE:
					var message:Message = note.getBody() as Message;
					
					// Add the message to the view
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
					break;
				case ApplicationFacade.VALID_LOGIN:
					// Enable all chat windows
					for each (var chatView:ChatView in chatViews)
						chatView.enabled = true;
						
					break;
				case ApplicationFacade.DISCONNECT:
					// Disable all chat windows
					for each (chatView in chatViews)
						chatView.enabled = false;
						
					break;
				default:
					break;		
			}
		}
		
		/**
		 * Open up a chat window for this particular JID
		 * 
		 * @param	jid
		 */
		private function showChatWindow(jid:JID):ChatView {
			// If the window exists already don't do anything
			if (!chatViews[jid.toBareJID()]) {
				var chatView:ChatView = new ChatView();
				
				PopUpManager.addPopUp(chatView, viewComponent as DisplayObjectContainer, false);
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
		
		/**
		 * The user has typed a message and sent it
		 * 
		 * @param	chatEvent
		 */
		private function onSendMessage(chatEvent:ChatEvent):void {
			var chatView:ChatView = chatEvent.currentTarget as ChatView;
			
			// Construct a XIFF message
			var message:Message = new Message(chatEvent.getJID(), null, chatEvent.getMessage(), null, Message.CHAT_TYPE);
			
			// Echo it to our own view
			chatViews[chatView.getJID().toBareJID()].addMessage(message);
			
			// And send off a notification
			sendNotification(ApplicationFacade.SEND_MESSAGE, message);
		}
		
		/**
		 * The chat window has been closed
		 * 
		 * @param	event
		 */
		private function onChatViewClose(event:Event):void {
			var chatView:ChatView = event.currentTarget as ChatView;
			chatView.removeEventListener(Event.CLOSE, onChatViewClose);
			PopUpManager.removePopUp(chatView);
			
			// Delete the chat view from the associative array
			delete chatViews[chatView.getJID().toBareJID()];
		}

	}
}
