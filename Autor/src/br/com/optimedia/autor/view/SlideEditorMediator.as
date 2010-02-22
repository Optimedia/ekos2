package br.com.optimedia.autor.view
{
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.view.components.SlideEditor;
	
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class SlideEditorMediator extends Mediator
	{
		public static const NAME:String = 'SlideEditorMediator';
		
		//private var repositoryProxy:RepositoryManagerProxy;
		
		public function SlideEditorMediator(viewComponent:Object=null)
		{
			super(NAME+viewComponent.uid, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.backBtn.addEventListener( MouseEvent.CLICK, backBtnClick );
			
			//repositoryProxy = facade.retrieveProxy( RepositoryManagerProxy.NAME ) as RepositoryManagerProxy;
		}
		
		override public function onRemove():void {
			
		}
		
		public function get view():SlideEditor
		{
			return viewComponent as SlideEditor;
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
		
		private function backBtnClick(event:MouseEvent):void {
			sendNotification( NotificationConstants.BACK_TO_SUBJECT_MANAGER );
		}
	}
}