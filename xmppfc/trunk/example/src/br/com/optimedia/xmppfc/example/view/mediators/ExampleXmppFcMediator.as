package br.com.optimedia.xmppfc.example.view.mediators
{
	import br.com.optimedia.xmppfc.view.api.mediators.IChatMediator;
	import br.com.optimedia.xmppfc.view.api.mediators.ILoginMediator;
	import br.com.optimedia.xmppfc.view.api.mediators.IRosterMediator;
	import br.com.optimedia.xmppfc.view.base.mediators.BaseXmppFcMediator;
	
	public class ExampleXmppFcMediator extends BaseXmppFcMediator
	{
		public function ExampleXmppFcMediator(viewComponent:Object)
		{
			super(viewComponent);
		}
		
		override protected function newLoginMediator(): ILoginMediator {
			return new ExampleLoginMediator(application.loginView);
		}
		
		override protected function newRosterMediator(): IRosterMediator {
			return new ExampleRosterMediator(application.rosterView);
		}
		
		override protected function newChatMediator(): IChatMediator {
			return new ExampleChatMediator(application);
		}
	}
}