package br.com.optimedia.shell.view
{
	import br.com.optimedia.shell.model.MainAppProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	

	public class MainAppMediator extends Mediator
	{
		public static const NAME:String = 'MainAppMediator';
		
		private var proxy:MainAppProxy;
		
		public function MainAppMediator(viewComponent:MainApp=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			proxy = facade.retrieveProxy( MainAppProxy.NAME ) as MainAppProxy;
			proxy.retrieveContentArray();
		}
		
		public function get view():MainApp
		{
			return viewComponent as MainApp;
		}
		
		override public function listNotificationInterests():Array
		{
			return [MainAppProxy.CONTENT_ARRAY_NOTIFICATION];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case MainAppProxy.CONTENT_ARRAY_NOTIFICATION:
					view.contentList.dataProvider = note.getBody();
					break;
				default:
					break;
			}
		}
	}
}