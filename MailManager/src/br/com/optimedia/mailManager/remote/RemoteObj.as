package br.com.optimedia.mailManager.remote
{
	import br.com.optimedia.mailManager.assets.vo.LoginVO;
	import br.com.optimedia.mailManager.assets.vo.MsnVO;
	import br.com.optimedia.mailManager.view.mail.EnviadoEvent;
	
	import mx.collections.ArrayCollection;
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

		
		public function getLogin(login:LoginVO, result:Function):void {
			remoteService.source ="mailManager.MailManager";
			var asynkToken :AsyncToken = remoteService.getLogin(login);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));	
		}
		public function getMsn(result:Function):void {
			remoteService.source ="mailManager.MailManager";
			var asynkToken :AsyncToken = remoteService.getMsn();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));	
			
		}
		public function getMail(result:Function):void {
			remoteService.source ="mailManager.MailManager";
			var asynkToken :AsyncToken = remoteService.getMail();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));	
			
		}
		public function sendMail (listSelecMns:ArrayCollection, msn:MsnVO):void {
			remoteService.source ="mailManager.MailManager";
			var asynkToken :AsyncToken = remoteService.sendMail(listSelecMns, msn);
			//asynkToken.addResponder(new Responder(result, defaultFaultHandler));
			var enviado:EnviadoEvent = new EnviadoEvent(EnviadoEvent.ON_ENVIADO);
			
			FlexGlobals.topLevelApplication.dispatchEvent(enviado);
		}
		
	}
}