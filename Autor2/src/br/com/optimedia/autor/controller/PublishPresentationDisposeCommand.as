package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.view.PublishPresentationPopUpMediator;
	import br.com.optimedia.autor.view.components.PublishPresentationPopUp;
	
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class PublishPresentationDisposeCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			var instance:PublishPresentationPopUp =  notification.getBody() as PublishPresentationPopUp;
			
			facade.removeMediator( PublishPresentationPopUpMediator.NAME+instance.uid );
			
			System.gc();
			
		}
	}
}