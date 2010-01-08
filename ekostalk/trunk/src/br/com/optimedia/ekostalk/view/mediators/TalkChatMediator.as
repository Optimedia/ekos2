package br.com.optimedia.ekostalk.view.mediators
{
	import br.com.optimedia.xmppfc.view.api.components.IChatView;
	import br.com.optimedia.xmppfc.view.base.mediators.BaseChatMediator;

	import br.com.optimedia.ekostalk.view.components.TalkChatView;
	
	public class TalkChatMediator extends BaseChatMediator
	{
		public function TalkChatMediator(viewComponent:Object)
		{
			super(viewComponent);
		}
		
		override protected function newChatView(): IChatView {
			return new br.com.optimedia.ekostalk.view.components.TalkChatView();
		}

	}
}