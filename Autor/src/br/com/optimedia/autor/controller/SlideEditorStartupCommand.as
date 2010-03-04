package br.com.optimedia.autor.controller
{
	import br.com.optimedia.autor.view.SlideEditorMediator;
	import br.com.optimedia.autor.view.components.SlideEditor;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class SlideEditorStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void {
			
			var instance:SlideEditor = note.getBody() as SlideEditor;
			
			facade.registerMediator( new SlideEditorMediator( instance ) );
			
		}
	}
}