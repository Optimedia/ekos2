package br.com.optimedia.xmppfc.example.view.mediators
{
	import br.com.optimedia.xmppfc.model.XMPPProxy;
	import br.com.optimedia.xmppfc.view.base.mediators.BaseRosterMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class ExampleRosterMediator extends BaseRosterMediator
	{
		public function ExampleRosterMediator(viewComponent:Object)
		{
			super(viewComponent);
		}
		
		override public function onValidLogin(note: INotification): void {
			var xmppProxy:XMPPProxy = facade.retrieveProxy(XMPPProxy.NAME) as XMPPProxy;
			rosterView.enabled = true;
			rosterView.dataProvider = xmppProxy.getRosterDataProvider(); 
		}
	}
}