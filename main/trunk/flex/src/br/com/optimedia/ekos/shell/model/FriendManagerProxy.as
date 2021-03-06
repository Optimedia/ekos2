package br.com.optimedia.ekos.shell.model
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.generalcomponents.FaultHandler;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class FriendManagerProxy extends Proxy
	{
		public static const NAME:String = "FriendManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function FriendManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "main.FriendManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
			//Alert.show(event.fault.faultCode as String);
		}
		
		/* public function getAllFriends():void {
			var asynkToken:AsyncToken = remoteService.getAllFriends();
			asynkToken.addResponder( new Responder(getAllFriendsResult, generalFault) );
		}
		private function getAllFriendsResult(event:ResultEvent):void {
			if(event.result.length > 0) {
				sendNotification( NotificationConstants.GET_ALL_FRIENDS_RESULT, event.result );
				//Alert.show("finish me", "getAllFriendsResult");
			}
		} */

		public function findFriend(name:String):void {
			var asynkToken:AsyncToken = remoteService.findFriend(name);
			asynkToken.addResponder( new Responder(findFriendResult, generalFault) );
		}
		private function findFriendResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.FIND_FRIEND_RESULT_ARRAY, event.result);
			//Alert.show("finish me", "findFriendResult");
		}
		
		public function addFriend(friendID:uint):void {
			var asynkToken:AsyncToken = remoteService.addFriend(friendID);
			asynkToken.addResponder( new Responder(addFriendResult, generalFault) );
		}
		private function addFriendResult(event:ResultEvent):void {
			if( event.result == true ) sendNotification( NotificationConstants.ADD_FRIEND_OK );
		}
		
		public function removeFriend(friendID:uint):void {
			var asynkToken:AsyncToken = remoteService.removeFriend(friendID);
			asynkToken.addResponder( new Responder(removeFriendResult, generalFault) );
		}
		private function removeFriendResult(event:ResultEvent):void {
			if( event.result == true ) sendNotification( NotificationConstants.REMOVE_FRIEND_OK );
		}
	}
}