package br.com.optimedia.login.controller
{
	import br.com.optimedia.login.view.LembrarSenhaPopUpMediator;
	import br.com.optimedia.login.view.components.LembrarSenhaPopup;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class LembrarSenhaPopUpStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			var instance:LembrarSenhaPopup = notification.getBody() as LembrarSenhaPopup;
			
			facade.registerMediator( new LembrarSenhaPopUpMediator( instance ) );
		}
	}
}