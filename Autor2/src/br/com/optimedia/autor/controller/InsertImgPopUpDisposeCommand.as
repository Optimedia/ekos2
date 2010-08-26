package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.view.InsertImgPopUpMediator;
	
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class InsertImgPopUpDisposeCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			facade.removeMediator( InsertImgPopUpMediator.NAME );
			
			System.gc();
			
		}
	}
}