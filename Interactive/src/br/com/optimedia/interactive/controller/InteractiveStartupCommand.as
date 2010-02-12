package br.com.optimedia.interactive.controller
{
	import br.com.optimedia.interactive.model.InteractiveProxy;
	import br.com.optimedia.interactive.view.InteractiveMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class InteractiveStartupCommand extends SimpleCommand
	{
		
		override public function execute(notification:INotification):void {
			
			var instance:Interactive = notification.getBody() as Interactive;
			
			facade.registerProxy( new InteractiveProxy() );
			
			facade.registerMediator( new InteractiveMediator( instance ) );
			
		}
		
	}
}