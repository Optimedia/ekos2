package br.com.optimedia.ekos.shell.model
{
	import br.com.optimedia.assets.vo.MessageVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class AvatarManagerProxy extends Proxy
	{
		public static const NAME:String = "AvatarManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function AvatarManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "main.AvatarManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			Alert.show(event.fault.faultCode as String);
		}
		
		public function addFriend(myID:uint, friendID:uint):void {
			var asynkToken:AsyncToken = remoteService.addFriend(myID, friendID);
			asynkToken.addResponder( new Responder(addFriendResult, generalFault) );
		}
		private function addFriendResult(event:ResultEvent):void {
			Alert.show("finish me", "addFriendResult");
		}
		public function addIgnore(myID:uint, friendID:uint):void {
			var asynkToken:AsyncToken = remoteService.addIgnore(myID, friendID);
			asynkToken.addResponder( new Responder(addIgnoreResult, generalFault) );
		}
		private function addIgnoreResult(event:ResultEvent):void {
			Alert.show("finish me", "addIgnoreResult");
		}
		public function sendPrivateMesage(messageVO:MessageVO):void {
			var asynkToken:AsyncToken = remoteService.addIgnore(messageVO);
			asynkToken.addResponder( new Responder(sendPrivateMesageResult, generalFault) );
		}
		private function sendPrivateMesageResult(event:ResultEvent):void {
			Alert.show("finish me", "sendPrivateMesageResult");
		}
	}
}