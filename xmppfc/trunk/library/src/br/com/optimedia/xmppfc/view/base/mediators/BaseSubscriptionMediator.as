package br.com.optimedia.xmppfc.view.base.mediators
{
	import br.com.optimedia.xmppfc.model.XmppfcFacade;
	import br.com.optimedia.xmppfc.view.api.components.ISubscriptionView;
	import br.com.optimedia.xmppfc.view.api.mediators.ISubscriptionMediator;
	import br.com.optimedia.xmppfc.view.base.components.BaseSubscriptionView;
	
	import flash.display.DisplayObject;
	
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class BaseSubscriptionMediator extends BaseMediator implements ISubscriptionMediator
	{
		public static const NAME:String = "SubscriptionMediator";

		public function BaseSubscriptionMediator(viewComponent:Object) {
			super(NAME, viewComponent);
			this.initializeNotifier("XmppfcFacade");
		}
		
		// overrides
		override public function listNotificationInterests():Array {
			return [
						XmppfcFacade.SUBSCRIPTION_DENIAL,
						XmppfcFacade.SUBSCRIPTION_REQUEST,
						XmppfcFacade.SUBSCRIPTION_REVOCATION/*,
						XmppfcFacade.USER_AVAILABLE,
						XmppfcFacade.USER_UNAVAILABLE*/
					];
		}
						
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {
				case XmppfcFacade.SUBSCRIPTION_DENIAL:
				
					subscriptionDenial(note);
					break;
				case XmppfcFacade.SUBSCRIPTION_REQUEST:
					Alert.show("SUBSCRIPTION_REQUEST");
					subscriptionRequest(note);
					break;
				case XmppfcFacade.SUBSCRIPTION_REVOCATION:
					subscriptionRevocation(note);
					break;
/*
				case XmppfcFacade.USER_AVAILABLE:
					subscriptionAvailable(node);
					break;
				case XmppfcFacade.USER_UNAVAILABLE:
					subscriptionUnAvailable(node);
					break;
*/
				default:
					break;		
			}
		}
		public function subscriptionDenial(note:INotification):void {
			xmppfcFacade.removeContact(null);
		}
		public function subscriptionRequest(note:INotification):void  {
			//Alert.show("notify");
			newSubscriptionView().visible = true;
			
			var subscriptionView:ISubscriptionView = newSubscriptionView();
				
			PopUpManager.addPopUp(subscriptionView, (viewComponent as DisplayObject), false);
			PopUpManager.bringToFront(subscriptionView);
			PopUpManager.centerPopUp(subscriptionView);
				
			//subscriptionView.addEventListener(Event.CLOSE, onChatViewClose);
			//subscriptionView.addEventListener(ChatEvent.SEND_MESSAGE, onSendMessage);
			//subscriptionView.setJID(jid);
				
			// Add the chat view to the associative array
			//chatViews[jid.toBareJID()] = subscriptionView;

		}
		public function subscriptionRevocation(note:INotification):void  {
			
		}
		public function subscriptionAvailable(note:INotification):void  {
			
		}
		public function subscriptionUnAvailable(note:INotification):void  {
			
		}
		public function newSubscriptionView(): ISubscriptionView {
			return new BaseSubscriptionView();
		}
	}
}