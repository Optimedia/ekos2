package br.com.optimedia.autor.view
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import br.com.optimedia.autor.assets.NotificationConstants;

	public class AutorMediator extends Mediator
	{
		public static const NAME:String = 'AutorMediator';
		
		//private var friendManagerProxy:FriendManagerProxy;
		
		public function AutorMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.showModuleManager();
			view.showSlideEditor();
			//ignoreManagerProxy = facade.retrieveProxy( IgnoreManagerProxy.NAME ) as IgnoreManagerProxy;
		}
		
		override public function onRemove():void {
			
		}
		
		public function get view():Autor
		{
			return viewComponent as Autor;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.BEGIN_PRESENTATION_EDIT,
					NotificationConstants.BACK_TO_SUBJECT_MANAGER];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.BEGIN_PRESENTATION_EDIT:
					view.viewStack.selectedIndex++;
					break;
				case NotificationConstants.BACK_TO_SUBJECT_MANAGER:
					view.viewStack.selectedIndex--;
					break;
				default:
					break;
			}
		}
	}
}