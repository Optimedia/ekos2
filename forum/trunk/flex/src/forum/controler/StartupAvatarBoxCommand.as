package forum.controler
{
	import forum.view.AvatarBoxMediator;
	import forum.view.component.AvatarBox;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class StartupAvatarBoxCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var view:AvatarBox = note.getBody() as AvatarBox;
			// Inicializa a Model primeiro (Proxies)
			
			// depois inicializa a View (Mediators)
			facade.registerMediator( new AvatarBoxMediator( view ) );
		}
	}
}