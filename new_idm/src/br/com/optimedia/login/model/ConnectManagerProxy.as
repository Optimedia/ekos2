package br.com.optimedia.login.model
{
	import br.com.optimedia.assets.FaultHandler;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import br.com.optimedia.assets.vo.UserVO;
	import br.com.optimedia.LoginAppFacade;
	import br.com.optimedia.assets.NotificationConstants;

	public class ConnectManagerProxy extends Proxy
	{
		public static const NAME:String = "ConnectManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function ConnectManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "idm.ConnectManager";
			remoteService.showBusyCursor = false;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
		}
		
		public function doLogin(login:String, senha:String):void {
			var asynkToken:AsyncToken = remoteService.doLogin(login, senha);
			asynkToken.addResponder( new Responder(doLoginResult, generalFault) );
		}
		private function doLoginResult(event:ResultEvent):void {
			if( event.result is UserVO ) {
				LoginAppFacade(facade).userVO = event.result as UserVO;
				sendNotification( NotificationConstants.DO_LOGIN_OK, event.result );
			}
		}
	}
}