package br.com.optimedia.ekos.shell.controler
{
	import br.com.optimedia.ekos.shell.view.SendPrivateMessagePopUpMediator;
	import br.com.optimedia.ekos.shell.view.component.SendPrivateMessagePopUp;
	
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class SendPrivateMessagePopUpDisposeCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var instance:SendPrivateMessagePopUp = note.getBody() as SendPrivateMessagePopUp;
			
			facade.removeMediator( SendPrivateMessagePopUpMediator.NAME );
			
			System.gc();
		}
	}
}