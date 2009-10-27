package forum.controler
{
	import flash.system.System;
	
	import forum.view.AdminViewMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class DisposeAdminViewCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			facade.removeMediator( AdminViewMediator.NAME );
			
			System.gc();
		}
	}
}