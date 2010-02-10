package br.com.optimedia.ekos.shell.controller
{
	import br.com.optimedia.ekos.shell.view.MailBoxViewMediator;
	import br.com.optimedia.ekos.shell.view.component.MailBoxView;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class MailBoxViewStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var instance:MailBoxView = note.getBody() as MailBoxView;
			
			// depois inicializa a View (Mediators)
			facade.registerMediator( new MailBoxViewMediator( instance ) );
		}
	}
}