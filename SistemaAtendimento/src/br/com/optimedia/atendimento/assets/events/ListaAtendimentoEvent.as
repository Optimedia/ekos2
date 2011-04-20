package br.com.optimedia.atendimento.assets.events
{
	import flash.events.Event;
	
	import org.osmf.net.StreamType;
	
	public class ListaAtendimentoEvent extends Event
	{
		public static const ADD_USER_LIST:String = "ADD_USER_LIST";
		/*public static const ACESS_SHARE_OBJ:String = "ACESS_SHARE_OBJ";*/
		
		public var login:UsuarioVO;
		
		public function ListaAtendimentoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}