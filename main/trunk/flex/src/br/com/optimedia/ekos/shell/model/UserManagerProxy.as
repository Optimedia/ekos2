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

	public class UserManagerProxy extends Proxy
	{
		public static const NAME:String = "UserManagerProxy";
		
		private var remoteService:RemoteObject;
		
		public function UserManagerProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		override public function onRegister():void {
			trace(NAME+".onRegister()");
			remoteService = new RemoteObject();
			remoteService.destination = "amfphp";
			remoteService.source = "main.UserManager";
			remoteService.showBusyCursor = true;
		}
		
		private function generalFault(event:FaultEvent):void {
			FaultHandler.handleFault(event);
			//Alert.show(event.fault.faultCode as String);
		}

		public function trySignUp(completeUserVO:CompleteUserVO):void {
			var userOK:Boolean;
			var emailOK:Boolean;
			
			// VERIFICA SE O NOME DE USUÁRIO JÁ EXISTE
			var asynkToken:AsyncToken = remoteService.verifName(completeUserVO.name);
			asynkToken.addResponder( new Responder(verifNameResult, generalFault) );
			function verifNameResult(event:ResultEvent):void {
				userOK = event.result;
				
				if(userOK) {
					// VERIFICA SE O E-MAIL JÁ EXISTE
					var asynkToken1:AsyncToken = remoteService.verifEmail(completeUserVO.email);
					asynkToken1.addResponder( new Responder(verifEmailResult, generalFault) );
					function verifEmailResult(event:ResultEvent):void {
						emailOK = event.result;
						
						if(emailOK) {
							// SE NÃO EXISTEM CRIA NOVO USUÁRIO
							var asynkToken2:AsyncToken = remoteService.insertUser(completeUserVO);
							asynkToken2.addResponder( new Responder(trySignUpResult, generalFault) );
						}
						else Alert.show("E-mail já cadastrado", "Atenção");
					}
				}
				else Alert.show("Nome de usuário já cadastrado", "Atenção");
			}
		}
		private function trySignUpResult(event:ResultEvent):void {
			if(event.result == true) sendNotification( NotificationConstants.INSERT_USER_OK );
		}
		
		public function rememberPassword(email:String):void {
			// VERIFICA SE O E-MAIL ESTÁ CADASTRADO
			var asynkToken:AsyncToken = remoteService.verifEmail(email);
			asynkToken.addResponder( new Responder(verifEmailResult, generalFault) );
			function verifEmailResult(event:ResultEvent):void {
				// SE O E-MAIL ESTIVER CADASTRADO event.result = false
				if(event.result == false) {
					var asynkToken1:AsyncToken = remoteService.getPassword(email);
					asynkToken1.addResponder( new Responder(rememberPasswordResult, generalFault) );
				}
				else Alert.show("Este e-mail não está cadastrado", "Atenção");
			}
		}
		private function rememberPasswordResult(event:ResultEvent):void {
			// FIX ME
			// REMOVER 'is String' e substituir por '== true' quando for implementado no PHP
			if(event.result is String) sendNotification( NotificationConstants.REMEMBER_PASSWORD_OK );
			else if(event.result == false) Alert.show("E-mail inexistente", "Atenção");
		}
		
		public function emailConfirm(userName:String, code:String):void {
			// VERIFICA SE O USUÁRIO EXISTE
			var asynkToken:AsyncToken = remoteService.verifName(userName);
			asynkToken.addResponder( new Responder(verifNameResult, generalFault) );
			function verifNameResult(event:ResultEvent):void {
				// SE O USUÁRIO EXISTIR event.result = false
				if(event.result == false) {
					var asynkToken1:AsyncToken = remoteService.confEmail(userName, code);
					asynkToken1.addResponder( new Responder(emailConfirmResult, generalFault) );
				}
				else Alert.show("Usuário inexistente", "Atenção");
			}
			
		}
		private function emailConfirmResult(event:ResultEvent):void {
			if(event.result == true) sendNotification( NotificationConstants.EMAIL_CONFIRM_OK );
			if(event.result == false) Alert.show("Código inválido", "Atenção");
		}
		
		
		public function updateUser(completeUserVO:CompleteUserVO):void {
			var asynkToken:AsyncToken = remoteService.updateUser(completeUserVO);
			asynkToken.addResponder( new Responder(updateUserResult, generalFault) );
		}
		private function updateUserResult(event:ResultEvent):void {
			if(event.result==true) sendNotification( NotificationConstants.UPDATE_USER_OK, event.result );
		}
	}
}