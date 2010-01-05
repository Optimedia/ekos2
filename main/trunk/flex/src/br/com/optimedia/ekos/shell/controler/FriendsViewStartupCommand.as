package br.com.optimedia.ekos.shell.controler
{
	import br.com.optimedia.ekos.shell.view.FriendsViewMediator;
	import br.com.optimedia.ekos.shell.view.component.FriendsView;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class FriendsViewStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var instance:FriendsView = note.getBody() as FriendsView;
			
			// depois inicializa a View (Mediators)
			facade.registerMediator( new FriendsViewMediator( instance ) );
		}
	}
}