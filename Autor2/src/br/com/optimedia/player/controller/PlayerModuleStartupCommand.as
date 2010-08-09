package br.com.optimedia.player.controller
{
	import br.com.optimedia.player.view.PlayerModuleMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class PlayerModuleStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			var instance:PlayerModule = notification.getBody() as PlayerModule;
			
			facade.registerMediator( new PlayerModuleMediator( instance ) );
			
		}
	}
}