package br.com.optimedia.interactive.controller
{
	import br.com.optimedia.interactive.view.SlideMediator;
	import br.com.optimedia.interactive.view.components.SlideView;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class SlideViewStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			var instance:SlideView = notification.getBody() as SlideView;
			
			facade.registerMediator( new SlideMediator( instance ) );
			
		}
	}
}