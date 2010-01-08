package br.com.optimedia.ekostalk.view.mediators
{
	import br.com.optimedia.xmppfc.view.api.mediators.IChatMediator;
	import br.com.optimedia.xmppfc.view.api.mediators.ILoginMediator;
	import br.com.optimedia.xmppfc.view.api.mediators.IRosterMediator;
	import br.com.optimedia.xmppfc.view.base.mediators.BaseXmppFcMediator;
	
	public class TalkMediator extends BaseXmppFcMediator
	{
		public function TalkMediator(viewComponent:Object)
		{
			super(viewComponent);
		}
		
		override protected function newLoginMediator(): ILoginMediator {
			return new TalkLoginMediator(application.loginView);
		}
		
		override protected function newRosterMediator(): IRosterMediator {
			return new TalkRosterMediator(application.rosterView);
		}
		
		override protected function newChatMediator(): IChatMediator {
			return new TalkChatMediator(application);
		}
	}
}