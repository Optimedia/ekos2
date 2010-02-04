package br.com.optimedia.xmppfc.view.base.mediators
{
	import br.com.optimedia.xmppfc.model.XmppfcFacade;
	import br.com.optimedia.xmppfc.events.ChatEvent;
	import br.com.optimedia.xmppfc.model.proxy.XMPPProxy;
	import br.com.optimedia.xmppfc.view.api.components.IRosterView;
	import br.com.optimedia.xmppfc.view.api.mediators.IRosterMediator;
	
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	
	public class BaseRosterMediator extends Mediator implements IRosterMediator {
		
		public static const NAME:String = "XmppFcRosterMediator";

		public function BaseRosterMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			this.initializeNotifier("XmppfcFacade");
			rosterView.addEventListener(ChatEvent.START_CHAT, onStartChat);
		}
		
		// overrides
		override public function getMediatorName():String {
			return NAME;
		}
		
		override public function listNotificationInterests():Array {
			return [
						XmppfcFacade.VALID_LOGIN,
						XmppfcFacade.DISCONNECT
					];
		}

		override public function handleNotification(note:INotification):void {
			var xmppProxy:XMPPProxy = facade.retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
			
			switch (note.getName()) {
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
			sendNotification(XmppfcFacade.OPEN_CHAT_WINDOW, chatEvent.getJID());
		}

	}
}