package br.com.optimedia.interactive.controller
{
	import br.com.optimedia.interactive.view.MenuMediator;
	import br.com.optimedia.interactive.view.components.MenuView;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class MenuViewStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			var instance:MenuView = notification.getBody() as MenuView;
			
			facade.registerMediator( new MenuMediator( instance) );
			
		}
		
	}
}