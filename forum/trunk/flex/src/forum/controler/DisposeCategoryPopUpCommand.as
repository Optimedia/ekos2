package forum.controler
{
	import flash.system.System;
	
	import forum.view.CategoryPopUpMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class DisposeCategoryPopUpCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			// Inicializa a Model primeiro (Proxies)
			
			// depois inicializa a View (Mediators)
			facade.removeMediator( CategoryPopUpMediator.NAME );
			
			System.gc();
		}
	}
}