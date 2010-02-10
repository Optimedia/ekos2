package br.com.optimedia.ekos.shell.controller
{
	
	import br.com.optimedia.ekos.shell.model.AvatarManagerProxy;
	import br.com.optimedia.ekos.shell.model.FriendManagerProxy;
	import br.com.optimedia.ekos.shell.model.ProfileManagerProxy;
	import br.com.optimedia.ekos.shell.model.SsoConnectProxy;
	import br.com.optimedia.ekos.shell.model.UserManagerProxy;
	import br.com.optimedia.ekos.shell.view.AppsTabNavigatorMediator;
	import br.com.optimedia.ekos.shell.view.MainAppMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class StartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var instance:MainApp = note.getBody() as MainApp;
			
			// inicializa a View (Mediators)
			facade.registerMediator( new AppsTabNavigatorMediator( instance.appsTabNavigator ) );
			facade.registerMediator( new MainAppMediator( instance ) );
		}
	}
}