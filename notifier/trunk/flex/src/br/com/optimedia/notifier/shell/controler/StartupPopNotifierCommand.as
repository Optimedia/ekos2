package br.com.optimedia.notifier.shell.controler
{
	import br.com.optimedia.notifier.shell.view.PopNotifierMediator;
	import br.com.optimedia.notifier.shell.view.component.PopNotifier;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class StartupPopNotifierCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var app:PopNotifier = note.getBody() as PopNotifier;
			// Inicializa a Model primeiro (Proxies)
			//facade.registerProxy( new TesteProxy() );
			
			// depois inicializa a View (Mediators)
			facade.registerMediator( new PopNotifierMediator( app ) );
			
			//facade.registerMediator( new MainComponentMediator ( app.mainComponent ) );
		}
	}
}