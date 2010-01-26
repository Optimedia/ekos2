package br.com.optimedia.xmppfc.view.base.mediators
{
	
	import br.com.optimedia.xmppfc.model.XmppfcFacade;
	
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class BaseMediator extends Mediator
	 {

		public function BaseMediator(name:String, viewComponent:Object) 
		{
			super(name, viewComponent);
		}
		
		protected function get xmppfcFacade() : XmppfcFacade {
			return XmppfcFacade.getInstance();
		}

	}
}