package br.com.optimedia.atendimento.assets.events
{
	import br.com.optimedia.atendimento.assets.vo.UsuarioVO;
	
	import flash.events.Event;

	public class LoginEvent extends Event
	{
		public static const ON_LOGAR:String = "ON_LOGAR";
		public static const LOGIN_SUCESSO:String = "LOGIN_SUCESSO";
		public static const BACK_USER:String = "BACK_USER";
		
		private var _login:UsuarioVO;
		private var _login_result:*;
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}

		public function get login_result():*	{
			return _login_result;
		}

		public function set login_result(value:*):void{
			_login_result = value;
		}

		public function get login():UsuarioVO {
			return _login;
		}

		public function set login(value:UsuarioVO):void{
			_login = value;
		}

	}
}

