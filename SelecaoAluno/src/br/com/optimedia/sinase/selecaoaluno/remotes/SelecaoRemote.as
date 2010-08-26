package br.com.optimedia.sinase.selecaoaluno.remotes
{
	import br.com.optimedia.sinase.selecaoaluno.vo.FilterVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class SelecaoRemote
	{
		private var bridge:RemoteObject;
		
		private static var instance:SelecaoRemote;
		
		public function SelecaoRemote()
		{
			bridge = new RemoteObject();
			
			bridge.destination = "amfphp";
			
			// nome da classe que vc vai mapear
			bridge.source = "sinase.SelecaoManager";

		}

		public static function getInstance():SelecaoRemote {
			if(instance == null ) {
				instance = new SelecaoRemote;
			}
			return instance;
		}			
		
		private function defaultFaultHandler(event:FaultEvent):void {
			Alert.show(event.fault.faultDetail, event.fault.faultString);
		}

		public function getAluno(id_aluno:int, result:Function):void {
			bridge.showBusyCursor = true;
			var async:AsyncToken = bridge.getAluno(id_aluno);
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function getAllAluno(result:Function):void {
			bridge.showBusyCursor = true;
			var async:AsyncToken = bridge.getAllAluno();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function setSelecionadoAluno(id_aluno:int, valor:int, result:Function):void {
			bridge.showBusyCursor = true;
			var async:AsyncToken = bridge.setSelecionadoAluno(id_aluno, valor);
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function getAllFilter(filter:FilterVO, result:Function):void {
			bridge.showBusyCursor = true;
			var async:AsyncToken = bridge.getAllFilter(filter);
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function getAllSelecionado(result:Function):void {
			bridge.showBusyCursor = false;
			var async:AsyncToken = bridge.getAllSelecionado();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function getCountAluno(result:Function):void {
			bridge.showBusyCursor = false;
			var async:AsyncToken = bridge.getCountAluno();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function getCountSelecionado(result:Function):void {
			bridge.showBusyCursor = false;
			var async:AsyncToken = bridge.getCountSelecionado();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}

	}
}