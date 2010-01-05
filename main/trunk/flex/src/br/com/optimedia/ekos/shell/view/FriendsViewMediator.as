package br.com.optimedia.ekos.shell.view
{
	import br.com.optimedia.ekos.shell.view.component.FriendsView;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class FriendsViewMediator extends Mediator
	{
		public static const NAME:String = 'FriendsViewMediator';
		
		//private var userManagerProxy:UserManagerProxy;
		
		public function FriendsViewMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			//userManagerProxy = facade.retrieveProxy( UserManagerProxy.NAME ) as UserManagerProxy;
			//view.addEventListener( ChangeAvatarPopUp.UPLOAD_FILE_EVENT, uploadFile );
		}
		
		override public function onRemove():void {
			trace(NAME+".onRemove()");
		}
		
		public function get view():FriendsView
		{
			return viewComponent as FriendsView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				default:
					break;
			}
		}
	}
}