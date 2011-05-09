package br.com.optimedia.mailManager.view.mail
{
	import flash.events.Event;
	
	public class EnviadoEvent extends Event
	{
		public static const ON_ENVIADO:String = "ON_ENVIADO";
		public static const VOLTAR:String = "VOLTAR";
		
		public function EnviadoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}