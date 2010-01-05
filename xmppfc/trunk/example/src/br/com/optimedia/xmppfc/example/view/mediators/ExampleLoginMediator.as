package br.com.optimedia.xmppfc.example.view.mediators
{
	import br.com.optimedia.xmppfc.example.view.components.LoginView;
	import br.com.optimedia.xmppfc.view.base.mediators.BaseLoginMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class ExampleLoginMediator extends BaseLoginMediator
	{
		public function ExampleLoginMediator(viewComponent:Object)
		{
			super(viewComponent);
		}
		
		override public function doValidLogin(note: INotification): void {
			(loginView as br.com.optimedia.xmppfc.example.view.components.LoginView).connectButton.enabled = false;
			(loginView as br.com.optimedia.xmppfc.example.view.components.LoginView).disconnectButton.enabled = true;
		}
		
		override public function doInvalidLogin(note: INotification): void {
			(loginView as br.com.optimedia.xmppfc.example.view.components.LoginView).showInvalidLoginAlert();
		}
		
		override public function doDisconnect(note: INotification): void {
			(loginView as br.com.optimedia.xmppfc.example.view.components.LoginView).connectButton.enabled = true;
			(loginView as br.com.optimedia.xmppfc.example.view.components.LoginView).disconnectButton.enabled = false;
		}

	}
}