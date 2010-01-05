package br.com.optimedia.xmppfc.view.api.mediators
{
	import br.com.optimedia.xmppfc.events.ChatEvent;
	import br.com.optimedia.xmppfc.view.api.components.IRosterView;
	
	import org.puremvc.as3.interfaces.IMediator;

	public interface IRosterMediator extends IMediator
	{
		function get rosterView(): IRosterView;
		function onStartChat(chatEvent: ChatEvent): void;
	}
}