package shell.view
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import shell.model.BookmarkProxy;

	public class BookmarkMediator extends Mediator
	{
		public static const NAME:String = 'BookmarkMediator';
		
		private var proxy:BookmarkProxy;
		
		public function BookmarkMediator(viewComponent:Bookmark=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace("Bookmark");
			proxy = facade.retrieveProxy( BookmarkProxy.NAME ) as BookmarkProxy;
			proxy.getLocale();
		}
		
		public function get view():Bookmark
		{
			return viewComponent as Bookmark;
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