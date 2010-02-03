package br.com.optimedia.ekos.shell.controler
{
	import br.com.optimedia.ekos.shell.view.ChangeAvatarPopUpMediator;
	import br.com.optimedia.ekos.shell.view.component.ChangeAvatarPopUp;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class ChangeAvatarPopUpStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var instance:ChangeAvatarPopUp = note.getBody() as ChangeAvatarPopUp;
			
			// depois inicializa a View (Mediators)
			facade.registerMediator( new ChangeAvatarPopUpMediator( instance ) );
		}
	}
}