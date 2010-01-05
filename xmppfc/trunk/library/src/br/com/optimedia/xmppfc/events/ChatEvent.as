package br.com.optimedia.xmppfc.events {
	import flash.events.Event;
	import org.jivesoftware.xiff.core.JID;
	
	/**
	* This event is related to the ChatViews
	* 
	* @author Dave Keen
	*/
	public class ChatEvent extends Event {
		
		public static const START_CHAT:String = "start_chat";
		public static const SEND_MESSAGE:String = "send_message";
		
		private var jid:JID;
		private var message:String;
		
		public function ChatEvent(type:String, jid:JID, message:String = null, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
			this.jid = jid;
			this.message = message;
		} 
		
		public function getJID():JID {
			return jid;
		}
		
		public function getMessage():String {
			return message;
		}
		
		public override function clone():Event { 
			return new ChatEvent(type, jid, message, bubbles, cancelable);
		} 
		
	}
	
}