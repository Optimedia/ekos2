package br.com.optimedia.xmppfc.view.base.mediators
{
	import br.com.optimedia.xmppfc.model.XmppfcFacade;
	import br.com.optimedia.xmppfc.view.api.components.ISubscriptionView;
	import br.com.optimedia.xmppfc.view.api.mediators.ISubscriptionMediator;
	import br.com.optimedia.xmppfc.view.base.components.BaseSubscriptionView;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import org.jivesoftware.xiff.core.JID;
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
						XmppfcFacade.SUBSCRIPTION_REQUEST,
						XmppfcFacade.SUBSCRIPTION_DENIAL,
						XmppfcFacade.SUBSCRIPTION_REVOCATION
					];
		}
						
		override public function handleNotification(note:INotification):void {
			switch (note.getName()) {
				case XmppfcFacade.SUBSCRIPTION_DENIAL:
					subscriptionDenial(note);
					break;
				case XmppfcFacade.SUBSCRIPTION_REQUEST:
					subscriptionRequest(note);
					break;
				case XmppfcFacade.SUBSCRIPTION_REVOCATION:
					subscriptionRevocation(note);
					break;
				/*
				case XmppfcFacade.USER_AVAILABLE:
				//	userAavailable(note);
					break;
				case XmppfcFacade.USER_UNAVAILABLE:
				//	userUnavailable(note);
					break;
				*/
				default:
					break;		
			}
		}
	
		public function newSubscriptionView(): ISubscriptionView {
			var sv:BaseSubscriptionView = new BaseSubscriptionView();
			sv.addEventListener(FlexEvent.CREATION_COMPLETE, registerEvent);
			return sv;
		}
		public function registerEvent(event:Event):void {
			(event.target as BaseSubscriptionView).btDeny.addEventListener(MouseEvent.CLICK,userDeny);
			(event.target as BaseSubscriptionView).btAccept.addEventListener(MouseEvent.CLICK, userAceept);
			(event.target as BaseSubscriptionView).addEventListener(CloseEvent.CLOSE, close);
		}
	
		public function subscriptionRequest(note:INotification):void  {
			var jid: JID = note.getBody() as JID;
			var subscriptionView:ISubscriptionView = newSubscriptionView();	
				
			PopUpManager.addPopUp(subscriptionView, (viewComponent as DisplayObject), false);
			PopUpManager.bringToFront(subscriptionView);
			PopUpManager.centerPopUp(subscriptionView);
			            
			subscriptionView.setJID(jid);		
			
			if (xmppfcFacade.jidExists(jid)){
            	subscriptionView.jidExists(jid);
           	}
		}
		
		public function subscriptionDenial(note:INotification):void {
			var jid: JID = note.getBody() as JID;
			Alert.show(jid+ "Negou se pedido ou \n excluido da lista dele");
		}
		
		public function subscriptionRevocation(note:INotification):void  {
		}
		
		public function userDeny (event:Event):void {
			var jid:JID = ((event.target as Button).data as ISubscriptionView).getJID();
			XmppfcFacade.getInstance().denySubscription(jid);
			PopUpManager.removePopUp(event.target as BaseSubscriptionView);		
		}
		public function userAceept (event:Event):void {
			var jid:JID = ((event.target as Button).data as ISubscriptionView).getJID();
			XmppfcFacade.getInstance().grantSubscription(jid);
			PopUpManager.removePopUp(event.target as BaseSubscriptionView);

		}
		
		public function close(event:Event) :void {
			PopUpManager.removePopUp(event.target as BaseSubscriptionView);
			
		}
	}
}