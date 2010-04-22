package br.com.optimedia.sinase.remote {
	
	import br.com.optimedia.sinase.vo.AlunoVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class TutorRemote {
		
		private var bridge:RemoteObject;
		
		//----------------------------------------------
		//
		//	Singleton
		//
		//----------------------------------------------
		private static var instance:TutorRemote;
		public static function getInstance():TutorRemote {
			if(instance == null) {
				instance = new TutorRemote();
			}
			return instance;
		}
		
		//----------------------------------------------
		//
		//	getTutor
		//
		//----------------------------------------------
		public function getTutor(cpf:String, result:Function):void {
			var async:AsyncToken = bridge.getTutor(cpf);
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------------------------
		//
		//	saveTutor
		//
		//----------------------------------------------
		public function saveTutor(tutor:AlunoVO, result:Function):void {
			var async:AsyncToken = bridge.saveTutor(tutor);
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
		public function getAtividade(result:Function):void {
			var async:AsyncToken = bridge.getAtividade();
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
		//	getOffice
		//
		//----------------------------------------------
		public function getOffice(result:Function):void {
			var async:AsyncToken = bridge.getOffice();
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
		//	UserRemote
		//
		//----------------------------------------------
		public function TutorRemote() {
			
			bridge = new RemoteObject();
			
			bridge.showBusyCursor = true;
			bridge.destination = "amfphp";
			
			// nome da classe que vc vai mapear
			bridge.source = "sinase.TutorManager";
			
		}

	}
}