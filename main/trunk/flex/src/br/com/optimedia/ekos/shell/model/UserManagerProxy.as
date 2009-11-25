package br.com.optimedia.ekos.shell.model
{
	
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.vo.CompleteUserVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class UserManagerProxy extends Proxy
	{
		public static const NAME:String = "UserManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function UserManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "main.UserManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			Alert.show(event.fault.faultCode as String);
		}

		public function trySignUp(completeUserVO:CompleteUserVO):void {
			var asynkToken:AsyncToken = remoteService.insertUser(completeUserVO);
			asynkToken.addResponder( new Responder(trySignUpResult, generalFault) );
		}
		private function trySignUpResult(event:ResultEvent):void {
			if(event.result == true) sendNotification( NotificationConstants.INSERT_USER_OK );
		}
	}
}