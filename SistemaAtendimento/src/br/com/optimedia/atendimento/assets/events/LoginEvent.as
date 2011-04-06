package br.com.optimedia.atendimento.assets.events
{
	import br.com.optimedia.atendimento.assets.vo.UsuarioVO;
	
	import flash.events.Event;

	public class LoginEvent extends Event
	{
		public static const ON_LOGAR:String = "ON_LOGAR";
		public static const BACK_USER:String = "BACK_USER";
		public static const LOGIN_USER:String = "LOGIN_USER";
		
		private var _login:UsuarioVO;
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}

		public function get login():UsuarioVO {
			return _login;
		}

		public function set login(value:UsuarioVO):void{
			_login = value;
		}

	}
}

