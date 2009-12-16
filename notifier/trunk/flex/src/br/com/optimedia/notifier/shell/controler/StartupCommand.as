package br.com.optimedia.notifier.shell.controler
{
	import br.com.optimedia.notifier.shell.model.NotifierProxy;
	import br.com.optimedia.notifier.shell.view.CompNotifierDataMediator;
	import br.com.optimedia.notifier.shell.view.NotifierMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	
	public class StartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var app:Notifier = note.getBody() as Notifier;
			// Inicializa a Model primeiro (Proxies)
			facade.registerProxy( new NotifierProxy() );
			
			// depois inicializa a View (Mediators)
			//facade.registerMediator( new GerenciarUsuariosMediator() );
			facade.registerMediator( new NotifierMediator( app ) );
			
			//facade.registerMediator( new MainComponentMediator ( app.mainComponent ) );
			
			facade.registerMediator( new CompNotifierDataMediator (app.compNotifierData) );
			
			
		}
	}
}