package br.com.optimedia.xmppfc.view.base.mediators
{
	import br.com.optimedia.xmppfc.XmppfcFacade;
	import br.com.optimedia.xmppfc.events.LoginViewEvent;
	import br.com.optimedia.xmppfc.view.api.components.ILoginView;
	import br.com.optimedia.xmppfc.view.api.mediators.ILoginMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	
	public class BaseLoginMediator extends Mediator implements ILoginMediator {
		public static const NAME:String = "XmppFcLoginMediator";

		public function BaseLoginMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			this.initializeNotifier("XmppfcFacade");
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
						XmppfcFacade.VALID_LOGIN,
						XmppfcFacade.INVALID_LOGIN,
						XmppfcFacade.DISCONNECT
					];
		}

		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {
				case XmppfcFacade.VALID_LOGIN:
					doValidLogin(note);
					break;
				case XmppfcFacade.INVALID_LOGIN:
					doInvalidLogin(note);
					break;
				case XmppfcFacade.DISCONNECT:
					doDisconnect(note);
					break;
				default:
					break;		
			}
		}
		
		public function onConnectClick(loginViewEvent: LoginViewEvent): void {
			sendNotification(XmppfcFacade.LOGIN, loginViewEvent);
		}
		
		public function onDisconnectClick(loginViewEvent: LoginViewEvent): void {
			sendNotification(XmppfcFacade.LOGOUT, loginViewEvent);
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