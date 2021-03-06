package br.com.optimedia.ekos.shell.controller
{
	import br.com.optimedia.ekos.shell.view.LoginPanelMediator;
	
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class LoginPanelDisposeCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			facade.removeMediator( LoginPanelMediator.NAME );
			
			System.gc();
		}
	}
}