package br.com.optimedia.autor.view
{
	import br.com.optimedia.autor.assets.CommandConstants;
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.model.SubjectManagerProxy;
	import br.com.optimedia.autor.view.components.PublishPresentationPopUp;
	
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class PublishPresentationMediator extends Mediator
	{
		public static const NAME:String = 'PublishPresentationMediator';
		
		private var proxy:SubjectManagerProxy;
		
		public function PublishPresentationMediator(viewComponent:Object=null)
		{
			super(NAME+viewComponent.uid, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.saveBtn.addEventListener(MouseEvent.CLICK, saveHandler);
			view.cancelBtn.addEventListener(MouseEvent.CLICK, closeHandler);
			proxy = facade.retrieveProxy( SubjectManagerProxy.NAME ) as SubjectManagerProxy;
		}
		
		override public function onRemove():void {
			view.removePopup();
		}
		
		public function get view():PublishPresentationPopUp
		{
			return viewComponent as PublishPresentationPopUp;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.GET_SECTIONS_RESULT];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.GET_SECTIONS_RESULT:
					view.sectionComboBox.dataProvider = note.getBody() as Array;
					break;
				default:
					break;
			}
		}
		
		private function closeHandler(event:MouseEvent):void {
			sendNotification( CommandConstants.PUBLISH_PRESENTATION_DISPOSE, view );
		}
		
		private function saveHandler(event:MouseEvent):void {
			proxy.publishPresentation( view.presentationVO.presentation_id, view.sectionComboBox.selectedItem.section_id );
		}
	}
}