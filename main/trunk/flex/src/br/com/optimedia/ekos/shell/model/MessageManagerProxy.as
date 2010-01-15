package br.com.optimedia.ekos.shell.model
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.generalcomponents.FaultHandler;
	import br.com.optimedia.assets.vo.MessageVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class MessageManagerProxy extends Proxy
	{
		public static const NAME:String = "MessageManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function MessageManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "main.MessageManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
		}
		
		public function sendPrivateMessage(messageVO:MessageVO):void {
			var asynkToken:AsyncToken = remoteService.sendPrivateMessage(messageVO);
			asynkToken.addResponder( new Responder(sendPrivateMessageResult, generalFault) );
		}
		private function sendPrivateMessageResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.SEND_PRIVATE_MESSAGE_OK, event.result );
		}
		
		public function getInBoxMessages():void {
			var asynkToken:AsyncToken = remoteService.getInBoxMessages();
			asynkToken.addResponder( new Responder(getInBoxMessagesResult, generalFault) );
		}
		private function getInBoxMessagesResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.GET_INBOX_MESSAGES_RESULT, event.result );
		}
		
		public function getOutBoxMessages():void {
			var asynkToken:AsyncToken = remoteService.getOutBoxMessages();
			asynkToken.addResponder( new Responder(getOutBoxMessagesResult, generalFault) );
		}
		private function getOutBoxMessagesResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.GET_OUTBOX_MESSAGES_RESULT, event.result );
		}
		
		public function deleteMessage(messageID:uint):void {
			var asynkToken:AsyncToken = remoteService.deleteMessage(messageID);
			asynkToken.addResponder( new Responder(deleteMessageResult, generalFault) );
		}
		private function deleteMessageResult(event:ResultEvent):void {
			if(event.result == true) sendNotification( NotificationConstants.DELETE_MESSAGE_OK, event.result );
		}
	}
}