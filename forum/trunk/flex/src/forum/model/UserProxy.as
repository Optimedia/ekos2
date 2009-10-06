package forum.model
{
	//import forum.UserVO;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class UserProxy extends Proxy
	{
		public static const NAME:String = "UserProxy";
		
		//public var userVO:UserVO = new UserVO();
		
		private var remoteService:RemoteObject;
		
		public function UserProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "forum.UserService";
			remoteService.addEventListener(FaultEvent.FAULT, generalFault);
		}
		
		private function generalFault(event:FaultEvent):void {
			Alert.show(event.fault.faultCode as String);
		}
		
		public function getUserData():void {
			remoteService.addEventListener(ResultEvent.RESULT, getUserDataResult);
			remoteService.getUserData();
			
		}
		private function getUserDataResult(event:ResultEvent):void {
			remoteService.removeEventListener(ResultEvent.RESULT, getUserDataResult);
		}
	}
}