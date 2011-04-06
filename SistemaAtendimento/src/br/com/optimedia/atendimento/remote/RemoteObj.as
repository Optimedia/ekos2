package br.com.optimedia.atendimento.remote
{
	
	
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	
	public class RemoteObj
	{
		private var remoteService:RemoteObject;
		
		private static var instance:RemoteObj;
		
		
		public function RemoteObj() {
			remoteService = new RemoteObject();
			remoteService.showBusyCursor = true;
			remoteService.destination = "amfphp";
		}
		

		public static function getInstance():RemoteObj {
			if(instance == null ) {
				instance = new RemoteObj;
			}
			return instance;
		}			
		
		private function defaultFaultHandler(event:FaultEvent):void {
			Alert.show(event.fault.faultDetail, event.fault.faultString);
		}
		// inicio da parte do login
		/*public function loginUser (login:LoginVO, result:Function):void {
			remoteService.source ="projetoPlayer.LoginManager";
			var asynkToken:AsyncToken = remoteService.loginUser(login);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}*/
	}
}