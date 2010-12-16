package br.com.optimedia.autor.controller
{
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import br.com.optimedia.autor.view.components.CommentList;
	import br.com.optimedia.autor.view.CommentListMediator;

	public class CommentListStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			var instance:CommentList = notification.getBody() as CommentList;
			
			facade.registerMediator( new CommentListMediator( instance ) );
			
		}
	}
}