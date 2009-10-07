package forum.model
{
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ForumProxy extends Proxy
	{
		public static const NAME:String = "ForumProxy";
		
		//public static const USER_DATA_RESULT_NOTIFICATION:String = "USER_DATA_RESULT_NOTIFICATION";
		
		private var remoteService:RemoteObject;
		
		//private var userVO:UserVO;
		
		public function ForumProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "forum.ForumService";
			remoteService.addEventListener(FaultEvent.FAULT, generalFault);
		}
		
		private function generalFault(event:FaultEvent):void {
			Alert.show(event.fault.faultCode as String);
		}
		
		public function createNewCategory(categoryName:String):void {
			var asynkToken:AsyncToken = remoteService.createNewCategory(categoryName);
			asynkToken.addResponder( new Responder(createNewCategoryResult, generalFault) );
		}
		
		private function createNewCategoryResult(event:ResultEvent):void {
			
		}
		
		/* public function getUserData():void {
			remoteService.addEventListener(ResultEvent.RESULT, getUserDataResult);
			// ALTERAR COM USER_ID APÓS LOGIN
			remoteService.getUserData('0');
			
		}
		private function getUserDataResult(event:ResultEvent):void {
			remoteService.removeEventListener(ResultEvent.RESULT, getUserDataResult);
			//userVO = event.result as UserVO;
			sendNotification(USER_DATA_RESULT_NOTIFICATION, event.result as UserVO);
		} */
	}
}