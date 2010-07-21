package br.com.optimedia.login.model
{
	import br.com.optimedia.LoginAppFacade;
	import br.com.optimedia.assets.FaultHandler;
	import br.com.optimedia.assets.NotificationConstants;
	import br.com.optimedia.assets.vo.UserVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

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
		
		public function ativarConta(login:String, codigo:String):void {
			var asynkToken:AsyncToken = remoteService.ativarConta(login, codigo);
			asynkToken.addResponder( new Responder(ativarContaResult, generalFault) );
		}
		private function ativarContaResult(event:ResultEvent):void {
			if( event.result is UserVO ) {
				LoginAppFacade(facade).userVO = event.result as UserVO;
				sendNotification( NotificationConstants.ATIVAR_CONTA_OK, event.result );
			}
		}
		
		public function lembrarSenha( email:String ):void {
			var asynkToken:AsyncToken = remoteService.lembrarSenha( email );
			asynkToken.addResponder( new Responder(lembrarSenhaResult, generalFault) );
		}
		private function lembrarSenhaResult(event:ResultEvent):void {
			if( event.result == true ) {
				sendNotification( NotificationConstants.LEMBRAR_SENHA_OK );
			}
		}
	}
}