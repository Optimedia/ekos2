package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.view.SendFilePopUpMediator;
	import br.com.optimedia.autor.view.components.SendFilePopUp;
	
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class SendFilePopUpDisposeCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void {
			
			var instance:SendFilePopUp =  note.getBody() as SendFilePopUp;
			
			facade.removeMediator( SendFilePopUpMediator.NAME+instance.uid );
			
			System.gc();
		}
	}
}