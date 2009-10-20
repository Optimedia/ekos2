package shell.controler
{
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import shell.view.PopBookMediator;

	public class DisposePopBookCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			facade.removeMediator( PopBookMediator.NAME );
			
			System.gc();
		}
	}
}