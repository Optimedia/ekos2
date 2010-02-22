package br.com.optimedia.interactive.controller
{
	import br.com.optimedia.interactive.view.MidiaMediator;
	import br.com.optimedia.interactive.view.components.MidiaView;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class MidiaStartupCommand extends SimpleCommand {
		
		override public function execute(notification:INotification):void {
			
			var instance:MidiaView = notification.getBody() as MidiaView;
			
			facade.registerMediator( new MidiaMediator( instance ) );
			
		}
		
	}
}