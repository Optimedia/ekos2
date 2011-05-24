package br.com.optimedia.atendimento.assets.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class AtendenteEvent extends Event
	{
		public static const GET_ATENDENTES_RESULT:String = "GET_ATENDENTES_RESULT";
		
		public var listAtendente:ArrayCollection;
		
		public function AtendenteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}