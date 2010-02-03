package br.com.optimedia.ekos.contentcontainer.controller
{
	import br.com.optimedia.ekos.contentcontainer.view.ContentContainerMediator;
	import br.com.optimedia.ekos.contentcontainer.view.components.ContentContainer;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class ContentContainerStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void {
			
			var instance:ContentContainer = note.getBody() as ContentContainer;
			
			facade.registerMediator( new ContentContainerMediator( instance ) );
			
		}
	}
}