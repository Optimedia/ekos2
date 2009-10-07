package forum.controler
{
	import forum.model.ForumProxy;
	import forum.model.UserProxy;
	import forum.view.AvatarBoxMediator;
	import forum.view.ForumMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var app:Forum = note.getBody() as Forum;
			// Inicializa a Model primeiro (Proxies)
			//facade.registerProxy( new TesteProxy() );
			facade.registerProxy( new UserProxy() );
			facade.registerProxy( new ForumProxy() );
			
			// depois inicializa a View (Mediators)
			//facade.registerMediator( new GerenciarUsuariosMediator() );
			facade.registerMediator( new ForumMediator( app ) );
			
			facade.registerMediator( new AvatarBoxMediator( app.avatarBox ) );
			
		}
	}
}