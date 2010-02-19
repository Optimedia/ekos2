package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.model.FileManagerProxy;
	import br.com.optimedia.autor.model.RepositoryManagerProxy;
	import br.com.optimedia.autor.model.SubjectManagerProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class ModelStartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void {
			
			//registra os proxys
			facade.registerProxy( new RepositoryManagerProxy() );
			facade.registerProxy( new SubjectManagerProxy() );
			facade.registerProxy( new FileManagerProxy() );
			
		}
	}
}