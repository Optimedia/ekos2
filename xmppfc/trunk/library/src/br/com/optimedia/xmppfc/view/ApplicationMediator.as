/*
 Mediator - PureMVC
 */
package br.com.optimedia.xmppfc.view {
	import mx.core.Application;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import br.com.optimedia.xmppfc.ApplicationFacade;
	import br.com.optimedia.xmppfc.view.*;
	
	/**
	 * Top level mediator for the application.  Doesn't have much to do at present apart from registering its children.
	 */
	public class ApplicationMediator extends Mediator implements IMediator {
	
		// Cannonical name of the Mediator
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator(viewComponent:Object) {
			// pass the viewComponent to the superclass where 
			// it will be stored in the inherited viewComponent property
			super(NAME, viewComponent);
			registerMediators()
		}
		
		protected function registerMediators(): void {
			facade.registerMediator(new LoginMediator(application.loginView));
			facade.registerMediator(new RosterMediator(application.rosterView));
			facade.registerMediator(new ChatMediator(application));
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
			return ApplicationMediator.NAME;
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
					ApplicationFacade.LOGIN,
					ApplicationFacade.VALID_LOGIN,
					ApplicationFacade.INVALID_LOGIN,
					ApplicationFacade.SECURITY_ERROR
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
				case ApplicationFacade.LOGIN:
					doLogin(note);
					break;
				case ApplicationFacade.VALID_LOGIN:
					doValidLogin(note);
					break;
				case ApplicationFacade.INVALID_LOGIN:
					doInvalidLogin(note);
					break;
				case ApplicationFacade.SECURITY_ERROR:
					doSecurityError(note);
					break;
				default:
					break;		
			}
		}
		
		protected function get application():* {
			return Application.application;
		}
		
		protected function doLogin(note:INotification): void {
			application.enabled = false;
		}
		
		protected function doValidLogin(note:INotification): void {
			application.enabled = true;
		}
		
		protected function doInvalidLogin(note:INotification): void {
			application.enabled = true;
		}
		
		protected function doSecurityError(note:INotification): void {
			application.enabled = true;
			application.showSecurityAlert(note.getBody() as String);
		}
	}
}