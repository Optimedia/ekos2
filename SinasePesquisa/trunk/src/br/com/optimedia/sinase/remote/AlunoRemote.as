package br.com.optimedia.sinase.remote {
	
	import br.com.optimedia.sinase.vo.AlunoVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class AlunoRemote {
		
		private var bridge:RemoteObject;
		
		//----------------------------------------------
		//
		//	Singleton
		//
		//----------------------------------------------
		private static var instance:AlunoRemote;
		public static function getInstance():AlunoRemote {
			if(instance == null) {
				instance = new AlunoRemote();
			}
			return instance;
		}
		
		//----------------------------------------------
		//
		//	getAluno
		//
		//----------------------------------------------
		public function getAluno(cpf:String, result:Function):void {
			var async:AsyncToken = bridge.getAluno(cpf);
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	saveAluno
		//
		//----------------------------------------------
		public function saveAluno(aluno:AlunoVO, result:Function):void {
			var async:AsyncToken = bridge.saveAluno(aluno);
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	getUf
		//
		//----------------------------------------------
		public function getUf(result:Function):void {
			var async:AsyncToken = bridge.getUf();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	getEscolaridade
		//
		//----------------------------------------------
		public function getEscolaridade(result:Function):void {
			var async:AsyncToken = bridge.getEscolaridade();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	getAtuacao
		//
		//----------------------------------------------
		public function getAtuacao(result:Function):void {
			var async:AsyncToken = bridge.getAtuacao();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	getAtividade
		//
		//----------------------------------------------
		public function getCapacitacao(result:Function):void {
			var async:AsyncToken = bridge.getCapacitacao();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	getTecEad
		//
		//----------------------------------------------
		public function getTecEad(result:Function):void {
			var async:AsyncToken = bridge.getTecEad();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	getTecMdl
		//
		//----------------------------------------------
		public function getTecMdl(result:Function):void {
			var async:AsyncToken = bridge.getTecMdl();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	getBandaLarga
		//
		//----------------------------------------------
		public function getBandaLarga(result:Function):void {
			var async:AsyncToken = bridge.getBandaLarga();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	getBandaLarga
		//
		//----------------------------------------------
		public function getModalidade(result:Function):void {
			var async:AsyncToken = bridge.getModalidade();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	getWebCon
		//
		//----------------------------------------------
		public function getWebCon(result:Function):void {
			var async:AsyncToken = bridge.getWebCon();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	defaultFaultHandler
		//
		//----------------------------------------------
		private function defaultFaultHandler(event:FaultEvent):void {
			Alert.show(event.fault.faultDetail, event.fault.faultString);
		}
		
		//----------------------------------------------
		//
		//	AlunoRemote
		//
		//----------------------------------------------
		public function AlunoRemote() {
			
			bridge = new RemoteObject();
			
			bridge.showBusyCursor = true;
			bridge.destination = "amfphp";
			
			// nome da classe que vc vai mapear
			bridge.source = "sinase.AlunoManager";
			
		}

	}
}