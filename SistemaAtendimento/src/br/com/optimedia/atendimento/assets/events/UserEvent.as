package br.com.optimedia.atendimento.assets.events
{
	import com.br.optimedia.projetoPlayer.assest.vo.UserVO;
	
	import flash.events.Event;
	
	public class UserEvent extends Event
	{
		public static const STATUS_ITEM:String = "STATUS_ITEM";
		public static const ON_SALVAR:String = "ON_SALVAR";
		
		private var _user:UserVO;
		
		public function UserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		public function get user():UserVO{
			return _user;
		}

		public function set user(value:UserVO):void{
			_user = value;
		}

	}
}