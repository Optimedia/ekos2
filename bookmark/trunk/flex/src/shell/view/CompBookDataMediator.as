package shell.view
{
	import assets.vo.BookmarkVO;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import shell.model.BookmarkProxy;
	import shell.view.component.CompBookData;

	public class CompBookDataMediator extends Mediator
	{
		public static const NAME:String = 'CompBookDataMediator';
		
		private var proxy:BookmarkProxy = new BookmarkProxy();
		
		public function CompBookDataMediator(viewComponent:CompBookData=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			proxy = facade.retrieveProxy(BookmarkProxy.NAME) as BookmarkProxy;
			proxy.retrieveBookmark();
			
			view.addEventListener(CompBookData.ON_DELETE_EVENT, onDeleteEvent);

		}
		
		public function get view():CompBookData
		{
			return viewComponent as CompBookData;
		}
		
		override public function listNotificationInterests():Array
		{
			return [BookmarkProxy.GET_LOCALE_RESULT,
					BookmarkProxy.RETRIEVEBOOKMARK_RESULT,
					BookmarkProxy.DELETE_BOOKMARK_RESULT];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{	
				case BookmarkProxy.GET_LOCALE_RESULT:
					view.lng = new XML(note.getBody());
					break
				case BookmarkProxy.RETRIEVEBOOKMARK_RESULT:
					view.dataProvider = note.getBody() as Array; 
					break;
				case BookmarkProxy.DELETE_BOOKMARK_RESULT:
					proxy.retrieveBookmark();
				default:
					break;
			}
		}
		
		private function onDeleteEvent(event:Event):void {
			proxy.deleteBookmark( view.dpBook.selectedItem as BookmarkVO );
		}
	}
}