package br.com.optimedia.ekostalk.view.mediators
{
	import br.com.optimedia.ekostalk.view.components.LoginFormView;
	import br.com.optimedia.xmppfc.view.base.mediators.BaseLoginMediator;
	
	import mx.core.Application;
	
	import org.puremvc.as3.multicore.interfaces.INotification;

	public class TalkLoginMediator extends BaseLoginMediator
	{
		public function TalkLoginMediator(viewComponent:Object)
		{
			super(viewComponent);
		}
		
		private function get loginFormView(): LoginFormView {
			return (loginView as br.com.optimedia.ekostalk.view.components.LoginFormView);
		}
		
		
		override public function doValidLogin(note: INotification): void {
			loginFormView.hideModal();
			Application.application.mainBody.visible = true;
		}
		
		override public function doInvalidLogin(note: INotification): void {
			loginFormView.showInvalidLoginAlert("Invalid username/password");
		}
		
		override public function doDisconnect(note: INotification): void {
			Application.application.mainBody.visible = false;
			loginFormView.showModal();
		}

	}
}