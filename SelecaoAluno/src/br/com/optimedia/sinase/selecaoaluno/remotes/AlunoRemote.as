package br.com.optimedia.sinase.selecaoaluno.remotes
{
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	
	public class AlunoRemote
	{
		
		
		private var bridge:RemoteObject;
		
		private static var instance:AlunoRemote;
		
		public function AlunoRemote()
		{
			bridge = new RemoteObject();
			
			bridge.showBusyCursor = true;
			bridge.destination = "amfphp";
			
			// nome da classe que vc vai mapear
			bridge.source = "sinase.AlunoManager";

		}

		public static function getInstance():AlunoRemote {
			if(instance == null ) {
				instance = new AlunoRemote;
			}
			return instance;
		}			
		
		private function defaultFaultHandler(event:FaultEvent):void {
			Alert.show(event.fault.faultDetail, event.fault.faultString);
		}
		
		public function getEscolaridade(result:Function):void {
			var async:AsyncToken = bridge.getEscolaridade();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}

		public function getAtuacao(result:Function):void {
			var async:AsyncToken = bridge.getAtuacao();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}

		public function getUF(result:Function):void {
			var async:AsyncToken = bridge.getUF();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}	
		
		
		//--------------------------------------------------
		
		
		public function getCapacitacao(result:Function):void {
			var async:AsyncToken = bridge.getCapacitacao();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function getTecEad(result:Function):void {
			var async:AsyncToken = bridge.getTecEad();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function getTecMdl(result:Function):void {
			var async:AsyncToken = bridge.getTecMdl();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function getBandaLarga(result:Function):void {
			var async:AsyncToken = bridge.getBandaLarga();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function getModalidade(result:Function):void {
			var async:AsyncToken = bridge.getModalidade();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function getWebCon(result:Function):void {
			var async:AsyncToken = bridge.getWebCon();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}

	}
}