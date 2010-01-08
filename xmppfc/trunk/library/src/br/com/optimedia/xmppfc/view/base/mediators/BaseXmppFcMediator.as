package br.com.optimedia.xmppfc.view.base.mediators
{
	import br.com.optimedia.xmppfc.XmppfcFacade;
	import br.com.optimedia.xmppfc.view.api.mediators.IChatMediator;
	import br.com.optimedia.xmppfc.view.api.mediators.ILoginMediator;
	import br.com.optimedia.xmppfc.view.api.mediators.IRosterMediator;
	import br.com.optimedia.xmppfc.view.api.mediators.IXmppFcMediator;
	
	import mx.core.Application;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class BaseXmppFcMediator extends Mediator implements IXmppFcMediator {

		public static const NAME:String = "XmppFcApplicationMediator";

		public function BaseXmppFcMediator(viewComponent:Object) {
			// @ template method
			super(NAME, viewComponent);
			registerMediators()
		}
		
		// properties
		protected function get application():* {
			return Application.application;
		}
		
		protected function get facadeXmppFc(): XmppfcFacade {
			return facade as XmppfcFacade;
		}
		
		// overrides
		override public function getMediatorName():String {
			return NAME;
		}
		
		override public function listNotificationInterests(): Array {
			// @ template method
			return [
						XmppfcFacade.LOGIN,
						XmppfcFacade.VALID_LOGIN,
						XmppfcFacade.INVALID_LOGIN,
						XmppfcFacade.SECURITY_ERROR
					];
		}

		override public function handleNotification(note:INotification):void {
			// @ template method
			switch (note.getName()) {
				case XmppfcFacade.LOGIN:
					doLogin(note);
					break;
				case XmppfcFacade.VALID_LOGIN:
					doValidLogin(note);
					break;
				case XmppfcFacade.INVALID_LOGIN:
					doInvalidLogin(note);
					break;
				case XmppfcFacade.SECURITY_ERROR:
					doSecurityError(note);
					break;
				default:
					break;		
			}
		}
		
		// abstracts
		protected function registerMediators(): void {
			// @ template method
			facade.registerMediator(newLoginMediator());
			facade.registerMediator(newChatMediator());
			facade.registerMediator(newRosterMediator());
		}
		
		protected function newLoginMediator(): ILoginMediator {
			return new BaseLoginMediator(application.loginView);
		}
		
		protected function newChatMediator(): IChatMediator {
			return new BaseChatMediator(application);
		}
		
		protected function newRosterMediator(): IRosterMediator {
			return new BaseRosterMediator(application.rosterView);
		}

		// template methods
		public function doLogin(note:INotification): void {
			application.enabled = false;
		}
		
		public function doValidLogin(note:INotification): void {
			application.enabled = true;
		}
		
		public function doInvalidLogin(note:INotification): void {
			application.enabled = true;
		}
		
		public function doSecurityError(note:INotification): void {
			application.enabled = true;
			facadeXmppFc.emitSecurityAlert(note.getBody() as String);
		}

	}
}