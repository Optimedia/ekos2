package br.com.optimedia.atendimento.assets.events
{
	
	import br.com.optimedia.atendimento.assets.vo.ApresentacaoVO;
	
	import flash.events.Event;
	
	import mx.rpc.events.ResultEvent;
	
	public class ApresentacaoEvent extends Event
	{
		public static const GET_APRESENTACAO_RESULT:String 	= "GET_APRESENTACAO_RESULT";
		public static const ABRIR_APRESENTACAO:String 		= "ABRIR_APRESENTACAO";
		public static const CLOSE_APRESENTACAO:String 		= "CLOSE_APRESENTACAO";
		public static const MUDAR_PAGINA:String 			= "MUDAR_PAGINA";
		public static const VISUALIZAR_APRESENTACAO:String 	= "VISUALIZAR_APRESENTACAO";
		public static const DESCRICAO_APRESENTACAO:String 	= "DESCRICAO_APRESENTACAO";
		
		public var listaApresentacoes:Array;
		public var apresentacao:ApresentacaoVO;
		
		public function ApresentacaoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}