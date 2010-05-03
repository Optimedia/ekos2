package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.view.SendMediaPopUpMediator;
	import br.com.optimedia.autor.view.components.SendMediaPopUp;
	
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class SendMediaDisposeCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void {
			
			var instance:SendMediaPopUp =  note.getBody() as SendMediaPopUp;
			
			facade.removeMediator( SendMediaPopUpMediator.NAME+instance.uid );
			
			System.gc();
		}
	}
}