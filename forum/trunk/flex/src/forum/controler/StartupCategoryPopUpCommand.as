package forum.controler
{
	import forum.view.CategoryPopUpMediator;
	import forum.view.component.CategoryPopUp;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class StartupCategoryPopUpCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var view:CategoryPopUp = note.getBody() as CategoryPopUp;
			
			facade.registerMediator( new CategoryPopUpMediator( view ) );
		}
	}
}