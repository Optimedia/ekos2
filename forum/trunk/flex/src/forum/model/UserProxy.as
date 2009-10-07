package forum.model
{
	import assets.vo.UserVO;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class UserProxy extends Proxy
	{
		public static const NAME:String = "UserProxy";
		
		public static const USER_DATA_RESULT_NOTIFICATION:String = "USER_DATA_RESULT_NOTIFICATION";
		
		private var remoteService:RemoteObject;
		
		private var userVO:UserVO;
		
		public function UserProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "forum.UserService";
			remoteService.showBusyCursor = true;
			remoteService.addEventListener(FaultEvent.FAULT, generalFault);
		}
		
		private function generalFault(event:FaultEvent):void {
			Alert.show(event.fault.faultCode as String);
		}
		
		public function getUserData():void {
			remoteService.addEventListener(ResultEvent.RESULT, getUserDataResult);
			// ALTERAR COM USER_ID APÓS LOGIN
			remoteService.getUserData('0');
			
		}
		private function getUserDataResult(event:ResultEvent):void {
			remoteService.removeEventListener(ResultEvent.RESULT, getUserDataResult);
			//userVO = event.result as UserVO;
			sendNotification(USER_DATA_RESULT_NOTIFICATION, event.result as UserVO);
		}
	}
}