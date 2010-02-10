package br.com.optimedia.ekos.shell.controller
{
	import br.com.optimedia.ekos.shell.view.AvatarBoxMediator;
	import br.com.optimedia.ekos.shell.view.component.AvatarBox;
	
	import flash.system.System;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class AvatarBoxDisposeCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var instance:AvatarBox = note.getBody() as AvatarBox;
			
			facade.removeMediator( AvatarBoxMediator.NAME+instance.uid );
			
			System.gc();
		}
	}
}