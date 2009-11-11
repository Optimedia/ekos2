package br.com.optimedia.ekos.shell.controler
{
	
	import br.com.optimedia.ekos.shell.model.MainAppProxy;
	import br.com.optimedia.ekos.shell.view.MainAppMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class StartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var app:MainApp = note.getBody() as MainApp;
			
			// Inicializa a Model primeiro (Proxies)
			facade.registerProxy( new MainAppProxy() );
			
			// depois inicializa a View (Mediators)
			facade.registerMediator( new MainAppMediator( app ) );
		}
	}
}