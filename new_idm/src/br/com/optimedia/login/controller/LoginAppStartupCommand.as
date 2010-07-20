package br.com.optimedia.login.controller
{
	import br.com.optimedia.login.view.LoginAppMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class LoginAppStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			var instance:LoginApp = notification.getBody() as LoginApp;
			
			facade.registerMediator( new LoginAppMediator( instance ) );
		}
	}
}