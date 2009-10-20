package shell.controler
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import shell.view.PopBookMediator;
	import shell.view.component.PopBook;
	

	public class StartupPopBookCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var app:PopBook = note.getBody() as PopBook;
			// Inicializa a Model primeiro (Proxies)
			//facade.registerProxy( new TesteProxy() );
			
			// depois inicializa a View (Mediators)
			facade.registerMediator( new PopBookMediator( app ) );
			
			//facade.registerMediator( new MainComponentMediator ( app.mainComponent ) );
		}
	}
}