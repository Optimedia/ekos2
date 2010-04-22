package br.com.optimedia.sinase.remote {
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class PesquisaRemote {
		
		private var bridge:RemoteObject;
		
		//----------------------------------------------
		//
		//	Singleton
		//
		//----------------------------------------------
		private static var instance:PesquisaRemote;
		public static function getInstance():PesquisaRemote {
			if(instance == null) {
				instance = new PesquisaRemote();
			}
			return instance;
		}
		//----------------------------------------------
		//
		//	getAluno
		//
		//----------------------------------------------
		
		public function getAllAlunos(result:Function):void {
			var async:AsyncToken = bridge.getAllAlunos();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		//----------------------------------------------
		//
		//	getTutor
		//
		//----------------------------------------------
		public function getAll(result:Function):void {
			var async:AsyncToken = bridge.getAll();
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
		//	TutorRemote
		//
		//----------------------------------------------
		public function PesquisaRemote() {
			
			bridge = new RemoteObject();
			
			bridge.showBusyCursor = true;
			bridge.destination = "amfphp";
			
			// nome da classe que vc vai mapear
			bridge.source = "sinase.PesquisaManager";
			
		}

	}
}