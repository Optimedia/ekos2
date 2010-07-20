package br.com.optimedia.login.controller
{
	import br.com.optimedia.login.view.LembrarSenhaPopUpMediator;
	
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class LembrarSenhaPopUpDisposeCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			facade.removeMediator( LembrarSenhaPopUpMediator.NAME );
			
			System.gc();
		}
	}
}