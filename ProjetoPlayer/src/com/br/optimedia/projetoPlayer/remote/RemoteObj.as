package com.br.optimedia.projetoPlayer.remote
{
	
	
	import com.br.optimedia.projetoPlayer.assest.vo.InstanciaVO;
	import com.br.optimedia.projetoPlayer.assest.vo.LoginVO;
	import com.br.optimedia.projetoPlayer.assest.vo.UserVO;
	import com.br.optimedia.projetoPlayer.view.login.UsuarioLogado;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	
	public class RemoteObj
	{
		private var remoteService:RemoteObject;
		
		private static var instance:RemoteObj;
		
		
		public function RemoteObj() {
			remoteService = new RemoteObject();
			remoteService.showBusyCursor = true;
			remoteService.destination = "amfphp";
		}
		

		public static function getInstance():RemoteObj {
			if(instance == null ) {
				instance = new RemoteObj;
			}
			return instance;
		}			
		
		private function defaultFaultHandler(event:FaultEvent):void {
			Alert.show(event.fault.faultDetail, event.fault.faultString);
		}
		// inicio da parte do login
		public function loginUser (login:LoginVO, result:Function):void {
			remoteService.source ="projetoPlayer.LoginManager";
			var asynkToken:AsyncToken = remoteService.loginUser(login);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}
		public function rememberLogin (email:String, result:Function):void {
			remoteService.source ="projetoPlayer.LoginManager";
			var asynkToken:AsyncToken = remoteService.rememberLogin(email);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));			
		}
		// fim da parte do login
		//inicio da parte do usuario
		public function getUser (result:Function, instancia:uint = undefined):void{
			var login:LoginVO = UsuarioLogado.login;
			remoteService.source ="projetoPlayer.UserManager";
			var asynkToken:AsyncToken = remoteService.getUser(login, instancia);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));	
		}
		public function getUserDel (result:Function, instancia:uint = undefined):void{
			var login:LoginVO = UsuarioLogado.login;
			remoteService.source ="projetoPlayer.UserManager";
			var asynkToken:AsyncToken = remoteService.getUserDel(login, instancia);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));	
		}
		public function salvarUser (user:UserVO, result:Function):void{
			remoteService.source ="projetoPlayer.UserManager";
			var login:LoginVO = UsuarioLogado.login;
			var asynkToken:AsyncToken = remoteService.salvarUser(user, login);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));
		}
		public function mudarStatusUser (user:UserVO, result:Function):void{
			remoteService.source ="projetoPlayer.UserManager";
			var login:LoginVO = UsuarioLogado.login;
			var asynkToken:AsyncToken = remoteService.mudarStatusUser(user, login);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));
		}
		public function delUse (user:UserVO, result:Function):void{
			remoteService.source ="projetoPlayer.UserManager";
			var login:LoginVO = UsuarioLogado.login;
			var asynkToken:AsyncToken = remoteService.delUse(user, login);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));
		}
		public function getTipoUser (result:Function):void{
			remoteService.source ="projetoPlayer.UserManager";
			var asynkToken:AsyncToken = remoteService.getTipoUser();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));
		}
		// fim da parte do usuario
	
		// inicio da parte do tema
		public function getTema (result:Function):void{
			remoteService.source ="projetoPlayer.TemaManager";
			var asynkToken:AsyncToken = remoteService.getTema();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));
		}
		//fim da parte do tema
		//inicio da parte da instancia
		public function getlistInstanciaFiltro (result:Function):void{
			remoteService.source ="projetoPlayer.InstanciaManager";
			var asynkToken:AsyncToken = remoteService.getInstanciaFiltro();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));
		}
		public function getInstancia (result:Function):void{
			remoteService.source ="projetoPlayer.InstanciaManager";
			var asynkToken:AsyncToken = remoteService.getInstancia();
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));
		}
		public function salvarInstancia (instancia:InstanciaVO, result:Function){
			remoteService.source ="projetoPlayer.InstanciaManager";
			var login:LoginVO = UsuarioLogado.login;
			var asynkToken:AsyncToken = remoteService.salvarInstancia(instancia, login);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));
		}
		public function delInstancia(instancia:InstanciaVO, result:Function):void{
			remoteService.source ="projetoPlayer.InstanciaManager";
			var login:LoginVO = UsuarioLogado.login;
			var asynkToken:AsyncToken = remoteService.delInstancia(instancia, login);
			asynkToken.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		//fim da parte da instancia
		
		
	}
}