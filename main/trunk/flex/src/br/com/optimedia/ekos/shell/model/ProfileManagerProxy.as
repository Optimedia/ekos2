package br.com.optimedia.ekos.shell.model
{
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.generalcomponents.FaultHandler;
	import br.com.optimedia.assets.vo.CompleteUserVO;
	import br.com.optimedia.assets.vo.FileVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ProfileManagerProxy extends Proxy
	{
		public static const NAME:String = "ProfileManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function ProfileManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "main.ProfileManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
		}
		
		
		public function uploadFile(fileVO:FileVO):void {
			var asynkToken:AsyncToken = remoteService.uploadFile(fileVO);
			asynkToken.addResponder( new Responder(uploadFileResult, generalFault) );
		}
		private function uploadFileResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.AVATAR_UPLOAD_COMPLETE, event.result );
		}
		
		public function getEducationLevels():void {
			// AINDA NÃO IMPLEMENTADO NO PHP
			var asynkToken:AsyncToken = remoteService.getEducationLevels();
			asynkToken.addResponder( new Responder(getEducationLevelsResult, generalFault) );
		}
		private function getEducationLevelsResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.GET_EDUCATION_LEVELS_OK, event.result );
		}
		
		public function getAddressTypes():void {
			// AINDA NÃO IMPLEMENTADO NO PHP
			var asynkToken:AsyncToken = remoteService.getAddressTypes();
			asynkToken.addResponder( new Responder(getAddressTypesResult, generalFault) );
		}
		private function getAddressTypesResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.GET_ADDRESS_TYPES_OK, event.result );
		}
		
		public function getAvailableLanguages():void {
			// AINDA NÃO IMPLEMENTADO NO PHP
			var asynkToken:AsyncToken = remoteService.getAvailableLanguages();
			asynkToken.addResponder( new Responder(getAvailableLanguagesResult, generalFault) );
		}
		private function getAvailableLanguagesResult(event:ResultEvent):void {
			sendNotification( NotificationConstants.GET_AVAILABLE_LANGUAGES_OK, event.result );
		}
		
		public function getAllFriends():void {
			var asynkToken:AsyncToken = remoteService.getAllFriends();
			asynkToken.addResponder( new Responder(getAllFriendsResult, generalFault) );
		}
		private function getAllFriendsResult(event:ResultEvent):void {
			if(event.result.length > 0) {
				sendNotification( NotificationConstants.GET_ALL_FRIENDS_RESULT, event.result );
				//Alert.show("finish me", "getAllFriendsResult");
			}
		}
		
		public function getProfile():void {
			var asynkToken:AsyncToken = remoteService.getProfile();
			asynkToken.addResponder( new Responder(getProfileResult, generalFault) );
		}
		private function getProfileResult(event:ResultEvent):void {
			if(event.result is CompleteUserVO) sendNotification( NotificationConstants.USER_UPDATE_AVAILABLE, event.result );
		}
		
		public function getAllIgnores():void {
			var asynkToken:AsyncToken = remoteService.getAllIgnores();
			asynkToken.addResponder( new Responder(getAllIgnoresleResult, generalFault) );
		}
		private function getAllIgnoresleResult(event:ResultEvent):void {
			if(event.result) sendNotification( NotificationConstants.GET_ALL_IGNORES, event.result );
		}
	}
}