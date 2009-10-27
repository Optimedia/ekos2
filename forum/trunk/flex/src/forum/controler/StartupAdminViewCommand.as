package forum.controler
{
	import forum.view.AdminViewMediator;
	import forum.view.component.AdminView;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class StartupAdminViewCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var view:AdminView = note.getBody() as AdminView;
			
			facade.registerMediator( new AdminViewMediator( view ) );
		}
	}
}