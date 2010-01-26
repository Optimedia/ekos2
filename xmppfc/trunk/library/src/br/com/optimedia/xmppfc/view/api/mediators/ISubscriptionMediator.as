package br.com.optimedia.xmppfc.view.api.mediators
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public interface ISubscriptionMediator extends IMediator
	{
	//function subscriptionDenial(jid:JID): ISubscriptionView;
	function subscriptionRequest(note:INotification):void
	}
}