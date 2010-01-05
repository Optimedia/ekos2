package org.jivesoftware.xiff.data.im
{
	import mx.core.IPropertyChangeNotifier;
	
	import org.jivesoftware.xiff.core.JID;
	
	public interface Contact extends IPropertyChangeNotifier
	{
		function get jid():JID;
		function set jid(newJID:JID):void;
		
		function get displayName():String;
		function set displayName(name:String):void;
		
		function get show():String;
		function set show(newShow:String):void;
		
		function get online():Boolean;
		function set online(newOnline:Boolean):void;
	}
}