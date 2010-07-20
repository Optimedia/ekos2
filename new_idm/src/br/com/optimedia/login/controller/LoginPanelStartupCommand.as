package br.com.optimedia.login.controller
{
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import br.com.optimedia.login.view.components.LoginPanel;
	import br.com.optimedia.login.view.LoginPanelMediator;

	public class LoginPanelStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			var instance:LoginPanel = notification.getBody() as LoginPanel;
			
			facade.registerMediator( new LoginPanelMediator( instance ) );
		}
	}
}