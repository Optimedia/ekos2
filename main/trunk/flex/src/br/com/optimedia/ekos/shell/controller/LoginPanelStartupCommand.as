package br.com.optimedia.ekos.shell.controller
{
	import br.com.optimedia.ekos.shell.view.LoginPanelMediator;
	import br.com.optimedia.ekos.shell.view.component.LoginPanel;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class LoginPanelStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var instance:LoginPanel = note.getBody() as LoginPanel;
			
			// depois inicializa a View (Mediators)
			facade.registerMediator( new LoginPanelMediator( instance ) );
		}
	}
}