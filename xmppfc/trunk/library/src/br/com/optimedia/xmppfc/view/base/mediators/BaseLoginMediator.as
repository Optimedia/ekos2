package br.com.optimedia.xmppfc.view.base.mediators
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import br.com.optimedia.xmppfc.ApplicationFacade;
	import br.com.optimedia.xmppfc.model.XMPPProxy;
	import br.com.optimedia.xmppfc.events.LoginViewEvent;
	import br.com.optimedia.xmppfc.view.api.mediators.ILoginMediator;
	import br.com.optimedia.xmppfc.view.api.components.ILoginView;
	
	
	public class BaseLoginMediator extends Mediator implements ILoginMediator {
		public static const NAME:String = "XmppFcLoginMediator";

		public function BaseLoginMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			
			loginView.addEventListener(LoginViewEvent.LOGIN, onConnectClick);
			loginView.addEventListener(LoginViewEvent.LOGOUT, onDisconnectClick);
		}
		
		// overrides
		override public function getMediatorName():String {
			return NAME;
		}
		
		public function get loginView(): ILoginView {
			return viewComponent as ILoginView;
		}

		override public function listNotificationInterests():Array {
			return [
						ApplicationFacade.VALID_LOGIN,
						ApplicationFacade.INVALID_LOGIN,
						ApplicationFacade.DISCONNECT
					];
		}

		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {
				case ApplicationFacade.VALID_LOGIN:
					doValidLogin(note);
					break;
				case ApplicationFacade.INVALID_LOGIN:
					doInvalidLogin(note);
					break;
				case ApplicationFacade.DISCONNECT:
					doDisconnect(note);
					break;
				default:
					break;		
			}
		}
		
		public function onConnectClick(loginViewEvent: LoginViewEvent): void {
			sendNotification(ApplicationFacade.LOGIN, loginViewEvent);
		}
		
		public function onDisconnectClick(loginViewEvent: LoginViewEvent): void {
			sendNotification(ApplicationFacade.LOGOUT, loginViewEvent);
		}
		
		// abstract
		public function doValidLogin(note: INotification): void {
		}
		
		public function doInvalidLogin(note: INotification): void {
		}
		
		public function doDisconnect(note: INotification): void {
		}

		
	}
}