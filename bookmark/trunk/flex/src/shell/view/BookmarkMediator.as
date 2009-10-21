package shell.view
{
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class BookmarkMediator extends Mediator
	{
		public static const NAME:String = 'BookmarkMediator';
		
		//public static const GET_DADOS_OK:String = "GET_DADOS_OK";
		
		public function BookmarkMediator(viewComponent:Bookmark=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace("Bookmark");
			/* proxy = facade.retrieveProxy(IdaProxy.NAME) as IdaProxy;
			proxy.getDados("ida_modulos"); */
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