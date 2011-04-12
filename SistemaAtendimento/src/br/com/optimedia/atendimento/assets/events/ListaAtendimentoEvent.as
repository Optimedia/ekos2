package br.com.optimedia.atendimento.assets.events
{
	import flash.events.Event;
	
	public class ListaAtendimentoEvent extends Event
	{
		public static const ADD_USER_LIST:String = "ADD_USER_LIST";
		
		public function ListaAtendimentoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}