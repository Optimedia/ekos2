package br.com.optimedia.atendimento.assets.events
{
	import flash.events.Event;
	
	public class MySingletonEvent extends Event
	{
		public static const DESCONECTADO:String = "DESCONECTADO";
		
		public function MySingletonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}