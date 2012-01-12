package br.com.optimedia.sinase.remote
{
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
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
		public function getTutor(cpf:String, result:Function):void{
			remoteService.source ="sinase.TutorManager";
			var asynkToken:AsyncToken = remoteService.getTutor(cpf);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));	
		}
		public function getUf (result:Function):void {
			remoteService.source ="sinase.TutorManager";
			var asynkToken:AsyncToken = remoteService.getUf();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}
		public function getEscolaridade (result:Function):void {
			remoteService.source ="sinase.TutorManager";
			var asynkToken:AsyncToken = remoteService.getEscolaridade();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}
		public function getAtuacao (result:Function):void {
			remoteService.source ="sinase.TutorManager";
			var asynkToken:AsyncToken = remoteService.getAtuacao();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}
		public function getAtividade (result:Function):void {
			remoteService.source ="sinase.TutorManager";
			var asynkToken:AsyncToken = remoteService.getAtividade();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}
		public function getTecEad (result:Function):void {
			remoteService.source ="sinase.TutorManager";
			var asynkToken:AsyncToken = remoteService.getTecEad();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}
		public function getTecMdl (result:Function):void {
			remoteService.source ="sinase.TutorManager";
			var asynkToken:AsyncToken = remoteService.getTecMdl();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}
		public function getBandaLarga (result:Function):void {
			remoteService.source ="sinase.TutorManager";
			var asynkToken:AsyncToken = remoteService.getBandaLarga();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}
		public function getWebCon (result:Function):void {
			remoteService.source ="sinase.TutorManager";
			var asynkToken:AsyncToken = remoteService.getWebCon();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}
		public function getOffice (result:Function):void {
			remoteService.source ="sinase.TutorManager";
			var asynkToken:AsyncToken = remoteService.getOffice();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}
	}
}