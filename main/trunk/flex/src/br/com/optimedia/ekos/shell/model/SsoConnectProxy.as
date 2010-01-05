package br.com.optimedia.ekos.shell.model
{
	
	import br.com.optimedia.assets.constants.NotificationConstants;
	import br.com.optimedia.assets.generalcomponents.FaultHandler;
	import br.com.optimedia.assets.vo.CompleteUserVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class SsoConnectProxy extends Proxy
	{
		public static const NAME:String = "MainAppProxy";
		
		private var remoteService:RemoteObject;
		
		public function SsoConnectProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "main.SsoConnect";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
			/* if(event.fault.faultCode == "Client.Error.MessageSend")
				Alert.show("Não foi possível conectar ao servidor de login.", "Atenção");
			else Alert.show(event.fault.faultCode as String); */
		}
		
		public function doLogin(login:String, pass:String):void {
			var asynkToken:AsyncToken = remoteService.doLogin(login, pass);
			asynkToken.addResponder( new Responder(doLoginResult, generalFault) );
		}
		private function doLoginResult(event:ResultEvent):void {
			if (event.result is CompleteUserVO) sendNotification( NotificationConstants.LOGIN_OK, event.result );
			if (event.result == 1) Alert.show("Usuário inexistente ou senha não confere", "Atenção");
			if (event.result == 2) Alert.show("Usuário não ativado", "Atenção");
			if (event.result == 4) Alert.show("Usuário desativado", "Atenção");
			if (event.result == 5) Alert.show("Usuário bloqueado", "Atenção");
		}
		
		public function doLogout():void {
			var asynkToken:AsyncToken = remoteService.doLogout();
			asynkToken.addResponder( new Responder(doLogoutResult, generalFault) );
		}
		private function doLogoutResult(event:ResultEvent):void {
			if(event.result == true) sendNotification( NotificationConstants.LOGOUT_OK );
		}
	}
}