package br.com.optimedia.ekos.shell.controler
{
	import br.com.optimedia.ekos.shell.view.AvatarBoxMediator;
	import br.com.optimedia.ekos.shell.view.component.AvatarBox;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class AvatarBoxStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var instance:AvatarBox = note.getBody() as AvatarBox;
			
			// depois inicializa a View (Mediators)
			facade.registerMediator( new AvatarBoxMediator( instance ) );
		}
	}
}