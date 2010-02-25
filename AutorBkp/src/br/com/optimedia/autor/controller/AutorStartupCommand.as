package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.view.AutorMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class AutorStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			var instance:Autor = notification.getBody() as Autor;
			
			facade.registerMediator( new AutorMediator( instance ) );
			
		}
	}
}