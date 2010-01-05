package br.com.optimedia.xmppfc.example.view.mediators
{
	import br.com.optimedia.xmppfc.example.view.components.ChatView;
	import br.com.optimedia.xmppfc.view.api.components.IChatView;
	import br.com.optimedia.xmppfc.view.base.mediators.BaseChatMediator;
	
	public class ExampleChatMediator extends BaseChatMediator
	{
		public function ExampleChatMediator(viewComponent:Object)
		{
			super(viewComponent);
		}
		
		override protected function newChatView(): IChatView {
			return new br.com.optimedia.xmppfc.example.view.components.ChatView();
		}

	}
}