package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.view.InsertImgPopUpMediator;
	import br.com.optimedia.autor.view.components.InsertImgPopUp;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class InsertImgPopUpStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			var instance:InsertImgPopUp = notification.getBody() as InsertImgPopUp;
			
			facade.registerMediator( new InsertImgPopUpMediator( instance ) );
			
		}
	}
}