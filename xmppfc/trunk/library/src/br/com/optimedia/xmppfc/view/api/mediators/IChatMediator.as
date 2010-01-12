package br.com.optimedia.xmppfc.view.api.mediators
{
	import br.com.optimedia.xmppfc.events.ChatEvent;
	import br.com.optimedia.xmppfc.view.api.components.IChatView;
	
	import flash.events.Event;
	
	import org.jivesoftware.xiff.core.JID;
	import org.puremvc.as3.multicore.interfaces.IMediator;

	public interface IChatMediator extends IMediator
	{
		function get chatView(): IChatView;
		function showChatWindow(jid:JID): IChatView;
		function onSendMessage(chatEvent: ChatEvent): void;
		function onChatViewClose(event: Event): void;
	}
}