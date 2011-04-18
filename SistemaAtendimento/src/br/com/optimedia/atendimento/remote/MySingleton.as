package br.com.optimedia.atendimento.remote
{
	
import br.com.optimedia.atendimento.assets.events.LoginEvent;
import br.com.optimedia.atendimento.assets.vo.AtendimentoVO;
import br.com.optimedia.atendimento.view.client.ClienteAtendimento;

import flash.events.NetStatusEvent;
import flash.net.NetConnection;

import mx.controls.Alert;
import mx.core.FlexGlobals;
import mx.rpc.events.FaultEvent;

	public final class MySingleton {
		
		private static var instance:MySingleton = new MySingleton();
		public var nc:NetConnection = new NetConnection();
		public var connected:Boolean = false;
		private var _client:String;
		private static var _connecting:Boolean = false;
				
		public function MySingleton() {
			if( instance ) {
				Alert.show("Erro, use Singleton.getInstance() em vez de new Singleton()");
			}
		}

		public function get client():String{
			return _client;
		}

		public function set client(value:String):void{
			_client = value;
		}

		public static function get connecting():Boolean{
			return _connecting;
		}

		public static function set connecting(value:Boolean):void {
			_connecting = value;
		}

		public static function getInstance():MySingleton {
			return instance;
			
		}
		public function connect():void {
			if (!connected || connecting) {
				connecting = true;
				nc.client = instance;
				//nc.objectEncoding = 0;
				//nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
				//nc.connect("rtmp://10.1.1.26/author4/");
				nc.connect("rtmp://10.1.1.20/atendimento/", client);
				nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
				
			}
		}
		private function defaultfault(event:FaultEvent):void {
			Alert.show("erro " + event.fault.toString());
		}
		
		private function onNetStatus(e:NetStatusEvent):void{
			switch(e.info.code){
				case "NetConnection.Connect.Success":
					connected = true;
					break;
				case "NetConnection.Connect.Failed":
					break;
				case "NetConnection.Connect.Rejected":
					break;
				case "NetStream.Publish.Start":
					break;
				case "NetStream.Record.Start":
					break;
				case "NetStream.Unpublish.Success":
					break;
				case "NetStream.Record.Stop":
					break;
				case "NetStream.Record.Failed":
					break;
				case "NetStream.Record.DiskQuotaExceeded":
					break;
				case "NetStream.Record.NoAccess":
					break;
				case "NetStream.Publish.BadName":					
					break;
				default:
					Alert.show(e.info.code.toString());
					break;
			}
		}
		//
		// funções retorno asc  do atendimento
		public function iniciaAtendimento_Result(event:*):void {
			
			var atendimento:AtendimentoVO = new AtendimentoVO;
			atendimento.atendente_id_atendente = event['atendente_id_atendente'];
			atendimento.cliente = event['cliente'];
			atendimento.dt_fila = event['dt_fila'];
			atendimento.dt_fim = event['dt_fim'];
			atendimento.dt_inicio = event['dt_inicio'];
			atendimento.email = event['email'];
			atendimento.id_atendimento = event['id_atendimento'];
			atendimento.protocolo = event['protocolo'];
			
			ClienteAtendimento.atendimento = atendimento; 
			FlexGlobals.topLevelApplication.atendimentoApp.selectedIndex = 1;
			//nc.removeEventListener(NetStatusEvent.NET_STATUS, onNetStatus)
		}
		//
		//
		//
		//
		//
		public function loginAtendente_Result(event:*):void {
			var loginEvent:LoginEvent = new LoginEvent(LoginEvent.ON_LOGAR);
			loginEvent.login_result = event
			FlexGlobals.topLevelApplication.dispatchEvent(loginEvent);
			
		}
	}
}