package br.com.optimedia.xmppfc.view.api.components
{
	import mx.core.IFlexDisplayObject;
	
	import org.jivesoftware.xiff.core.JID;
	import org.jivesoftware.xiff.data.Message;

	public interface IChatView extends IFlexDisplayObject
	{
		function setJID(jid:JID): void;
		function getJID(): JID;
		function addMessage(message:Message): void;
		function isUserTyping(value:Boolean): void;
		function set enabled(value: Boolean): void;
	}
}