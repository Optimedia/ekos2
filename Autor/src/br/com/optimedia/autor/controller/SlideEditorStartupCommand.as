package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.view.PresentationEditorMediator;
	import br.com.optimedia.autor.view.components.PresentationEditor;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class SlideEditorStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void {
			
			var instance:PresentationEditor = note.getBody() as PresentationEditor;
			
			facade.registerMediator( new PresentationEditorMediator( instance ) );
			
		}
	}
}