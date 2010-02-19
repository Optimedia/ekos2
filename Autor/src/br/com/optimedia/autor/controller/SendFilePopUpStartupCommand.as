package br.com.optimedia.autor.controller
{
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import br.com.optimedia.autor.view.components.SendFilePopUp;
	import br.com.optimedia.autor.view.components.SendFilePopUpMediator;

	public class SendFilePopUpStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void {
			
			var instance:SendFilePopUp = note.getBody() as SendFilePopUp;
			
			facade.registerMediator( new SendFilePopUpMediator( instance ) );
			
		}
	}
}