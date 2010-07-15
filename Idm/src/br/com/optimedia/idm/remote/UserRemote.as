package br.com.optimedia.idm.remote {
	
	import br.com.optimedia.idm.vo.UserVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class UserRemote {
		
		private var bridge:RemoteObject;
		
		//----------------------------
		//	Singleton
		//----------------------------
		private static var instance:UserRemote;
		public static function getInstance():UserRemote {
			if(instance == null) {
				instance = new UserRemote();
			}
			return instance;
		}
		
		/**
		 * Função para executar o Login.
		 * 
		 * @param login String
		 * @param password String
		 * @return void 
		 */ 
		public function doLogin(login:String, password:String, node:String, result:Function):void {
			bridge.source = "idm.ConnectManager";
			
			var async:AsyncToken = bridge.doLogin(login, password, node);
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		/**
		 * 
		 * 
		 * @param login String
		 * @param password String
		 * @return void 
		 */ 
		public function doLogout(result:Function):void {
			bridge.source = "idm.ConnectManager";
			
			var async:AsyncToken = bridge.doLogout();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		/**
		 * 
		 * 
		 * @param login String
		 * @param password String
		 * @return void 
		 */ 
		public function getSession(result:Function):void {
			bridge.source = "idm.ConnectManager";
			
			var async:AsyncToken = bridge.getSession();
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		/**
		 * 
		 */ 
		public function tempInsert(user:UserVO, result:Function):void {
			bridge.source = "idm.InsertManager";
			
			var async:AsyncToken = bridge.tempInsert(user);
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		/**
		 * 
		 */ 
		public function confirmarEmail(login:String, code:String, result:Function):void {
			bridge.source = "idm.InsertManager";
			
			var async:AsyncToken = bridge.confirmarEmail(login, code);
			async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//----------------------------
		//	defaultFaultHandler
		//----------------------------
		private function defaultFaultHandler(event:FaultEvent):void {
			Alert.show(event.fault.faultDetail, event.fault.faultString);
		}
		
		//----------------------------
		//	Construtor
		//----------------------------
		public function UserRemote() {
			
			bridge = new RemoteObject();
			
			bridge.showBusyCursor = true;
			bridge.destination = "amfphp";
			
		}
		
	}
}