package br.com.optimedia.autor.controller
{
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import br.com.optimedia.autor.view.components.CommentList;
	import br.com.optimedia.autor.view.CommentListMediator;
	import flash.system.System;

	public class CommentListDisposeCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			facade.removeMediator( CommentListMediator.NAME );
			
			System.gc();
			
		}
	}
}