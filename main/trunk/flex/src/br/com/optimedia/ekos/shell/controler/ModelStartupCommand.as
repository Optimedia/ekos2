package br.com.optimedia.ekos.shell.controler
{
	import br.com.optimedia.ekos.shell.model.AvatarManagerProxy;
	import br.com.optimedia.ekos.shell.model.FriendManagerProxy;
	import br.com.optimedia.ekos.shell.model.ProfileManagerProxy;
	import br.com.optimedia.ekos.shell.model.SsoConnectProxy;
	import br.com.optimedia.ekos.shell.model.UserManagerProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class ModelStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			// Inicializa a Model (Proxies)
			facade.registerProxy( new SsoConnectProxy() );
			facade.registerProxy( new UserManagerProxy() );
			facade.registerProxy( new AvatarManagerProxy() );
			facade.registerProxy( new FriendManagerProxy() );
			facade.registerProxy( new ProfileManagerProxy() );
			
		}
	}
}