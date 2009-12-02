package br.com.optimedia.ekos.shell.controler
{
	
	import br.com.optimedia.ekos.shell.model.AvatarManagerProxy;
	import br.com.optimedia.ekos.shell.model.SsoConnectProxy;
	import br.com.optimedia.ekos.shell.model.UserManagerProxy;
	import br.com.optimedia.ekos.shell.view.AppsTabNavigatorMediator;
	import br.com.optimedia.ekos.shell.view.MainAppMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import br.com.optimedia.ekos.shell.model.FriendManagerProxy;

	public class StartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var instance:MainApp = note.getBody() as MainApp;
			
			// Inicializa a Model primeiro (Proxies)
			facade.registerProxy( new SsoConnectProxy() );
			facade.registerProxy( new UserManagerProxy() );
			facade.registerProxy( new AvatarManagerProxy() );
			facade.registerProxy( new FriendManagerProxy() );
			
			// depois inicializa a View (Mediators)
			facade.registerMediator( new AppsTabNavigatorMediator( instance.appsTabNavigator ) );
			facade.registerMediator( new MainAppMediator( instance ) );
		}
	}
}