package br.com.optimedia.xmppfc.view.api.components
{
	import mx.core.IFlexDisplayObject;
	
	import org.jivesoftware.xiff.core.JID;
	
	public interface ISubscriptionView extends IFlexDisplayObject
	{
		function setJID(jid:JID): void;
		function getJID(): JID;
		function jidExists(jid:JID):void;
		function close():void;
		
	}
}