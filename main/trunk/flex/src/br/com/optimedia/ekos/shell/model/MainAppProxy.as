package br.com.optimedia.ekos.shell.model
{
	
	import br.com.optimedia.assets.constants.NotificationConstants;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class MainAppProxy extends Proxy
	{
		public static const NAME:String = "MainAppProxy";
		
		private var remoteService:RemoteObject;
		
		public function MainAppProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "mainapp.MainAppService";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			Alert.show(event.fault.faultCode as String);
		}
		
		public function doLogin(login:String, pass:String):void {
			//var asynkToken:AsyncToken = remoteService.retrieveContentArray();
			//asynkToken.addResponder( new Responder(retrieveContentArrayResult, generalFault) );
			sendNotification( NotificationConstants.LOGIN_OK );
		}
		private function doLoginResult(event:ResultEvent):void {
			
		}
		
		public function retrieveContentArray():void {
			//var asynkToken:AsyncToken = remoteService.retrieveContentArray();
			//asynkToken.addResponder( new Responder(retrieveContentArrayResult, generalFault) );
			
		}
		private function retrieveContentArrayResult(event:ResultEvent):void {
			trace(NAME+".retrieveContentArrayResult() = "+event.result);
		}
	}
}