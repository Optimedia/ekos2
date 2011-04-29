package br.com.optimedia.atendimento.assets.events
{
	import flash.events.Event;
	
	public class VideoPublicadoEvent extends Event
	{
		public static const INICIAR_ENVIO_VIDEO:String = "INICIAR_ENVIO_VIDEO";
		public static const FINALIZAR_ENVIO_VIDEO:String = "FINALIZAR_ENVIO_VIDEO";
		
		public function VideoPublicadoEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}