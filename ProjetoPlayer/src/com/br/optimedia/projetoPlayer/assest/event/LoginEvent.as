package com.br.optimedia.projetoPlayer.assest.event
{
	import com.br.optimedia.projetoPlayer.assest.vo.LoginVO;
	
	import flash.events.Event;

	public class LoginEvent extends Event
	{
		public static const ON_LOGAR:String = "ON_LOGAR";
		public static const BACK_USER:String = "BACK_USER";
		public static const LOGIN_USER:String = "LOGIN_USER";
		
		private var _login:LoginVO;
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}

		public function get login():LoginVO {
			return _login;
		}

		public function set login(value:LoginVO):void{
			_login = value;
		}

	}
}

