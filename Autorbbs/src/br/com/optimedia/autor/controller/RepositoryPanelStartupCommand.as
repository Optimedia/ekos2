package br.com.optimedia.autor.controller
{
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import br.com.optimedia.autor.view.components.RepositoryPanel;
	import br.com.optimedia.autor.view.RepositoryPanelMediator;

	public class RepositoryPanelStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void {
			
			var instance:RepositoryPanel = note.getBody() as RepositoryPanel;
			
			facade.registerMediator( new RepositoryPanelMediator( instance ) );
			
		}
	}
}