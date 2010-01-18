package br.com.optimedia.ekos.shell.model
{
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import mx.rpc.remoting.mxml.RemoteObject;
	import mx.rpc.events.FaultEvent;
	import br.com.optimedia.assets.generalcomponents.FaultHandler;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import br.com.optimedia.assets.constants.NotificationConstants;
	import mx.rpc.Responder;

	public class IgnoreManagerProxy extends Proxy
	{
		public static const NAME:String = "IgnoreManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function IgnoreManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "main.IgnoreManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
		}
		
		public function addIgnore(userID:uint):void {
			var asynkToken:AsyncToken = remoteService.addIgnore(userID);
			asynkToken.addResponder( new Responder(addIgnoreResult, generalFault) );
		}
		private function addIgnoreResult(event:ResultEvent):void {
			if(event.result == true) sendNotification( NotificationConstants.ADD_IGNORE_OK, event.result );
		}
	}
}