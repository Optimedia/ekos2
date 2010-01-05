package br.com.optimedia.xmppfc.view.base.mediators
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import br.com.optimedia.xmppfc.events.ChatEvent;

	import br.com.optimedia.xmppfc.ApplicationFacade;
	import br.com.optimedia.xmppfc.model.XMPPProxy;
	import br.com.optimedia.xmppfc.view.api.mediators.IRosterMediator;
	import br.com.optimedia.xmppfc.view.api.components.IRosterView;
	
	
	public class BaseRosterMediator extends Mediator implements IRosterMediator {
		
		public static const NAME:String = "XmppFcRosterMediator";

		public function BaseRosterMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			rosterView.addEventListener(ChatEvent.START_CHAT, onStartChat);
		}
		
		// overrides
		override public function getMediatorName():String {
			return NAME;
		}
		
		override public function listNotificationInterests():Array {
			return [
						ApplicationFacade.VALID_LOGIN,
						ApplicationFacade.DISCONNECT
					];
		}

		override public function handleNotification(note:INotification):void {
			var xmppProxy:XMPPProxy = facade.retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
			
			switch (note.getName()) {
				case ApplicationFacade.VALID_LOGIN:
					onValidLogin(note);
					break;
				case ApplicationFacade.DISCONNECT:
					onDisconnect(note);
					break;
				default:
					break;		
			}
		}

		public function get rosterView(): IRosterView {
			return viewComponent as IRosterView;
		}
		
		public function onValidLogin(note:INotification): void {
			var xmppProxy:XMPPProxy = facade.retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
			rosterView.enabled = true;
			rosterView.dataProvider = xmppProxy.getRosterDataProvider(); 
		}
		
		public function onDisconnect(note:INotification): void {
			rosterView.enabled = false;
			rosterView.dataProvider = null;
		}
		
		public function onStartChat(chatEvent: ChatEvent): void {
			sendNotification(ApplicationFacade.OPEN_CHAT_WINDOW, chatEvent.getJID());
		}
		
	}
}