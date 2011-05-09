package br.com.optimedia.mailManager.view.login
{
	
	
	import br.com.optimedia.mailManager.assets.vo.LoginVO;
	
	import flash.events.Event;

	public class LoginEvent extends Event
	{
		public static const ON_LOGAR:String = "on_logar";
		public static const SALVAR_USER:String = "SALVAR_USER";
		
		private var _login:LoginVO;
		
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	
		
		public function get login():LoginVO
		{
			return _login;
		}

		public function set login(value:LoginVO):void
		{
			_login = value;
		}

	}
}

