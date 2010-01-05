/*
 Mediator - PureMVC
 */
package org.davekeen.xiffer.view {
	import mx.core.Application;
	import XIFFer;
	import org.davekeen.xiffer.ApplicationFacade;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.davekeen.xiffer.view.*;
	
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
					application.enabled = false;
					break;
				case ApplicationFacade.VALID_LOGIN:
				case ApplicationFacade.INVALID_LOGIN:
					application.enabled = true;
					break;
				case ApplicationFacade.SECURITY_ERROR:
					application.enabled = true;
					application.showSecurityAlert(note.getBody() as String);
					break;
				default:
					break;		
			}
		}
		
		private function get application():XIFFer {
			return Application.application as XIFFer;
		}

	}
}
