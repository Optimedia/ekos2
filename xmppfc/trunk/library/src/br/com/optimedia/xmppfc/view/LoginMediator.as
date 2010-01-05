/*
 Mediator - PureMVC
 */
package br.com.optimedia.xmppfc.view {
	import br.com.optimedia.xmppfc.ApplicationFacade;
	import br.com.optimedia.xmppfc.events.LoginViewEvent;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import br.com.optimedia.xmppfc.view.*;
	import br.com.optimedia.xmppfc.view.components_old.LoginView;
	
	/**
	 * Mediates the login area dealing with login and logout
	 */
	public class LoginMediator extends Mediator implements IMediator {
	
		// Cannonical name of the Mediator
		public static const NAME:String = "LoginMediator";
		
		public function LoginMediator(viewComponent:Object) {
			// pass the viewComponent to the superclass where 
			// it will be stored in the inherited viewComponent property
			super(NAME, viewComponent);
			
			loginView.addEventListener(LoginViewEvent.LOGIN, onConnectClick);
			loginView.addEventListener(LoginViewEvent.LOGOUT, onDisconnectClick);
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
			return LoginMediator.NAME;
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
					ApplicationFacade.INVALID_LOGIN,
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
				case ApplicationFacade.VALID_LOGIN:
					loginView.connectButton.enabled = false;
					loginView.disconnectButton.enabled = true;
					break;
				case ApplicationFacade.INVALID_LOGIN:
					loginView.showInvalidLoginAlert();
					break;
				case ApplicationFacade.DISCONNECT:
					loginView.connectButton.enabled = true;
					loginView.disconnectButton.enabled = false;
					break;
				default:
					break;		
			}
		}
		
		/**
		 * Helper getter to avoid having to cast the whole time
		 */
		private function get loginView():* {
			return viewComponent;
		}
		
		/**
		 * The connect button was clicked in the view
		 * 
		 * @param	loginViewEvent
		 */
		private function onConnectClick(loginViewEvent:LoginViewEvent):void {
			sendNotification(ApplicationFacade.LOGIN, loginViewEvent);
		}
		
		/**
		 * The disconnect button was clicked in the view
		 * 
		 * @param	loginViewEvent
		 */
		private function onDisconnectClick(loginViewEvent:LoginViewEvent):void {
			sendNotification(ApplicationFacade.LOGOUT, loginViewEvent);
		}

	}
}
