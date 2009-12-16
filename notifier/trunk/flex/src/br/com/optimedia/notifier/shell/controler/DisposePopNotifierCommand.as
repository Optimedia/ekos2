package br.com.optimedia.notifier.shell.controler
{
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import br.com.optimedia.notifier.shell.view.PopNotifierMediator;
	

	public class DisposePopNotifierCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			facade.removeMediator( PopNotifierMediator.NAME );			
			System.gc();
		}
	}
}