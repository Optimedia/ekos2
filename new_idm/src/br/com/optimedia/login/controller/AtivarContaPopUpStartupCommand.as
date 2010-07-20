package br.com.optimedia.login.controller
{
	import br.com.optimedia.login.view.AtivarContaPopUpMediator;
	import br.com.optimedia.login.view.components.AtivarContaPopUp;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class AtivarContaPopUpStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			var instance:AtivarContaPopUp = notification.getBody() as AtivarContaPopUp;
			
			facade.registerMediator( new AtivarContaPopUpMediator( instance ) );
		}
	}
}