package br.com.optimedia.login.controller
{
	import br.com.optimedia.login.view.AtivarContaPopUpMediator;
	
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class AtivarContaPopUpDisposeCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			facade.removeMediator( AtivarContaPopUpMediator.NAME );
			
			System.gc();
		}
	}
}