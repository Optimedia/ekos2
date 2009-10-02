package shell.controler
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	import shell.model.TesteProxy;
	import shell.view.MainComponentMediator;
	import shell.view.TesteMediator;
	
	public class StartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var app:Teste = note.getBody() as Teste;
			// Inicializa a Model primeiro (Proxies)
			facade.registerProxy( new TesteProxy() );
			
			// depois inicializa a View (Mediators)
			//facade.registerMediator( new GerenciarUsuariosMediator() );
			facade.registerMediator( new TesteMediator( app ) );
			
			facade.registerMediator( new MainComponentMediator ( app.mainComponent ) );
			
		}
	}
}