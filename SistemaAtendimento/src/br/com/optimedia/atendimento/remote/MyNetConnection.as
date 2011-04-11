package br.com.optimedia.atendimento.remote
{
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	
	public class MyNetConnection
	{
		
		public static var nc:NetConnection = new NetConnection();
	
		private static var connected:Boolean = false;
		
		public static function connect(client:Object):void {
			if (!connected) {
				nc.client = client;
				nc.objectEncoding = 0;
				//nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
				//nc.connect("rtmp://10.1.1.26/author4/");
				nc.connect("rtmp://10.1.1.20/atendimento/");
				
			}
		}
		public static function defaultfault(event:FaultEvent):void {
			Alert.show("erro " + event.fault.toString());
		}
		
		public static function onNetStatus(e:NetStatusEvent):void{
			switch(e.info.code){
				default:
					Alert.show(e.info.code.toString());
					break;
			}
		}
	}
}