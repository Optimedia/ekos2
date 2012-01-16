package br.com.optimedia.sinase.event
{
	import br.com.optimedia.sinase.vo.AlunoVO;
	
	import flash.events.Event;
	
	public class AlunoEvent extends Event
	{
		
		public static const GET_ALUNO_EVENT:String 	= "GET_ALUNO_EVENT";
		public static const CADASTRO_SUCESSO:String 	= "CADASTRO_SUCESSO";
		
		
		public var aluno:AlunoVO
		
		public function AlunoEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}