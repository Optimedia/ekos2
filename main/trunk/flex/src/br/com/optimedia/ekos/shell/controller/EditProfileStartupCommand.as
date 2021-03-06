package br.com.optimedia.ekos.shell.controller
{
	import br.com.optimedia.ekos.shell.model.UserManagerProxy;
	import br.com.optimedia.ekos.shell.model.ProfileManagerProxy;
	import br.com.optimedia.ekos.shell.view.EditProfileMediator;
	import br.com.optimedia.ekos.shell.view.component.EditProfile;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import br.com.optimedia.ekos.shell.model.ProfileManagerProxy;

	public class EditProfileStartupCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var instance:EditProfile = note.getBody() as EditProfile;
			
			// depois inicializa a View (Mediators)
			facade.registerMediator( new EditProfileMediator( instance ) );
		}
	}
}