package com.br.optimedia.projetoPlayer.assest.event
{
	import com.br.optimedia.projetoPlayer.assest.vo.InstanciaVO;
	
	import flash.events.Event;
	
	public class InstanciaEvent extends Event
	{
		
		private var _instacia:InstanciaVO
		
		public static const ON_SALVAR:String = "ON_SALVAR";
		
		public function InstanciaEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}

		public function get instacia():InstanciaVO{
			return _instacia;
		}

		public function set instacia(value:InstanciaVO):void{
			_instacia = value;
		}

	}
}