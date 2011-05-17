package br.com.optimedia.atendimento.assets.events
{
	
	import flash.events.Event;
	
	import mx.rpc.events.ResultEvent;
	
	public class ApresentacaoEvent extends Event
	{
		public static const GET_APRESENTACAO_RESULT:String = "GET_APRESENTACAO_RESULT";
		
		public var listaApresentacoes:Array;
		
		public function ApresentacaoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}