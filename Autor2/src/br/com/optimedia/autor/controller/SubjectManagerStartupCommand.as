package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.view.SubjectManagerMediator;
	import br.com.optimedia.autor.view.components.SubjectManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class SubjectManagerStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			var instance:SubjectManager = notification.getBody() as SubjectManager;
			
			facade.registerMediator( new SubjectManagerMediator( instance ) );
			
		}
	}
}