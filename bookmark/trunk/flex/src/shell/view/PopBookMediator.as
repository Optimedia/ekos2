package shell.view
{
	import flash.events.Event;
	
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import shell.model.BookmarkProxy;
	import shell.view.component.PopBook;

	public class PopBookMediator extends Mediator
	{
		public static const NAME:String = 'PopBookMediator';
		
		private var proxy:BookmarkProxy = new BookmarkProxy();
		
		//public static const GET_DADOS_OK:String = "GET_DADOS_OK";
		
		public function PopBookMediator(viewComponent:PopBook=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			view.addEventListener(PopBook.BOOKMARK_SAVE_EVENT, onBookmarkSaveEvent);
			proxy = facade.retrieveProxy(BookmarkProxy.NAME) as BookmarkProxy;			
		}
		
		public function get view():PopBook
		{
			return viewComponent as PopBook;
		}
		
		override public function listNotificationInterests():Array
		{
			return [BookmarkProxy.GET_LOCALE_RESULT,
					BookmarkProxy.SAVE_BOOKMARK_RESULT,
					BookmarkProxy.SAVE_BOOKMARK_FAULT];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{	
				case BookmarkProxy.GET_LOCALE_RESULT:
					view.lng = new XML(note.getBody());
					break;
				case BookmarkProxy.SAVE_BOOKMARK_RESULT:
					proxy.retrieveBookmark();
					view.fechar(); 
					break;
				case BookmarkProxy.SAVE_BOOKMARK_FAULT:
					proxy.retrieveBookmark();
					Alert.show(note.getBody() as String, "Atenção!");
					break;
				default:
					break;
			}
		}
		
		private function onBookmarkSaveEvent(event:Event):void
		{
			proxy.saveBookmark(view.bookmarkVO);
		}
	}
}