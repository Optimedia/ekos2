package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.view.SendMediaMediator;
	import br.com.optimedia.autor.view.components.SendMediaPopUp;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class SendMediaStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void {
			
			var instance:SendMediaPopUp = note.getBody() as SendMediaPopUp;
			
			facade.registerMediator( new SendMediaMediator( instance ) );
			
		}
	}
}