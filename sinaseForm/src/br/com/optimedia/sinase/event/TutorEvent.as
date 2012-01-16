package br.com.optimedia.sinase.event
{
	import br.com.optimedia.sinase.view.tutor.ViewReferencia;
	import br.com.optimedia.sinase.vo.TutorVO;
	
	import flash.events.Event;
	
	public class TutorEvent extends Event
	{
		public var tutorVO:TutorVO;
		public var viewReferencia:ViewReferencia;
		
		public static const GET_TUTOR_EVENT:String 	= "GET_TUTOR_EVENT";
		public static const REMOVER_REFERENCIA:String 	= "REMOVER_REFERENCIA";
		public static const CADASTRO_SUCESSO:String 	= "CADASTRO_SUCESSO";
		
		public function TutorEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}