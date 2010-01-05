/*
 Mediator - PureMVC
 */
package org.davekeen.xiffer.view {
	import org.davekeen.xiffer.ApplicationFacade;
	import org.davekeen.xiffer.events.ChatEvent;
	import org.davekeen.xiffer.model.XMPPProxy;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.davekeen.xiffer.view.*;
	import org.davekeen.xiffer.view.components.RosterView;
	
	/**
	 * Mediator dealing with the buddy list
	 */
	public class RosterMediator extends Mediator implements IMediator {
	
		// Cannonical name of the Mediator
		public static const NAME:String = "RosterMediator";
		
		public function RosterMediator(viewComponent:Object) {
			// pass the viewComponent to the superclass where 
			// it will be stored in the inherited viewComponent property
			super(NAME, viewComponent);
			
			rosterView.addEventListener(ChatEvent.START_CHAT, onStartChat);
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
			return RosterMediator.NAME;
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
			// Get the roster from the model and set it as a dataprovider to the list.
			var xmppProxy:XMPPProxy = facade.retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
			
			switch (note.getName()) {
				case ApplicationFacade.VALID_LOGIN:
					rosterView.titleWindow.enabled = true;
					viewComponent.rosterGrid.dataProvider = xmppProxy.getRosterDataProvider();
					break;
				case ApplicationFacade.DISCONNECT:
					rosterView.titleWindow.enabled = false;
					viewComponent.rosterGrid.dataProvider = null;
					break;
				default:
					break;		
			}
		}
		
		/**
		 * Helper getter to avoid having to cast the whole time
		 */
		private function get rosterView():RosterView {
			return viewComponent as RosterView;
		}
		
		/**
		 * The user has selected a buddy in the roster list and clicked on Chat...
		 * 
		 * @param	chatEvent
		 */
		private function onStartChat(chatEvent:ChatEvent):void {
			sendNotification(ApplicationFacade.OPEN_CHAT_WINDOW, chatEvent.getJID());
		}

	}
}
