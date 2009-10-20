package shell.controler
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import shell.model.BookmarkProxy;
	import shell.view.BookmarkMediator;
	import shell.view.CompBookDataMediator;
	
	public class StartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var app:Bookmark = note.getBody() as Bookmark;
			// Inicializa a Model primeiro (Proxies)
			facade.registerProxy( new BookmarkProxy() );
			
			// depois inicializa a View (Mediators)
			//facade.registerMediator( new GerenciarUsuariosMediator() );
			facade.registerMediator( new BookmarkMediator( app ) );
			
			//facade.registerMediator( new MainComponentMediator ( app.mainComponent ) );
			
			facade.registerMediator( new CompBookDataMediator (app.compBookData) );
			
			
		}
	}
}