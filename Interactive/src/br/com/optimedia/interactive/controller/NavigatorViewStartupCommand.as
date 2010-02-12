package br.com.optimedia.interactive.controller
{
	import br.com.optimedia.interactive.view.NavigatorMediator;
	import br.com.optimedia.interactive.view.components.NavigatorView;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class NavigatorViewStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			var instace:Interactive = notification.getBody() as NavigatorView;
			
			facade.registerMediator( new NavigatorMediator( instance ) );
			
		}
	}
}