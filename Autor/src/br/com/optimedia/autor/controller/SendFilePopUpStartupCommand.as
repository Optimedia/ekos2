package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.view.SendFilePopUpMediator;
	import br.com.optimedia.autor.view.components.SendFilePopUp;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class SendFilePopUpStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void {
			
			var instance:SendFilePopUp = note.getBody() as SendFilePopUp;
			
			facade.registerMediator( new SendFilePopUpMediator( instance ) );
			
		}
	}
}