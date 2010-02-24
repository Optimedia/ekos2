package br.com.optimedia.autor.view
{
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.assets.vo.PresentationVO;
	import br.com.optimedia.autor.model.SlideManagerProxy;
	import br.com.optimedia.autor.model.SubjectManagerProxy;
	import br.com.optimedia.autor.view.components.SlideEditor;
	
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class SlideEditorMediator extends Mediator
	{
		public static const NAME:String = 'SlideEditorMediator';
		
		private var proxy:SlideManagerProxy;
		private var subjectManagerProxy:SubjectManagerProxy;
		
		public function SlideEditorMediator(viewComponent:Object=null)
		{
			super(NAME+viewComponent.uid, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			view.backBtn.addEventListener( MouseEvent.CLICK, backBtnClick );
			
			proxy = facade.retrieveProxy( SlideManagerProxy.NAME ) as SlideManagerProxy;
			subjectManagerProxy = facade.retrieveProxy( SubjectManagerProxy.NAME ) as SubjectManagerProxy;
		}
		
		override public function onRemove():void {
			
		}
		
		public function get view():SlideEditor
		{
			return viewComponent as SlideEditor;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.BEGIN_PRESENTATION_EDIT,
					NotificationConstants.GET_SLIDES_OK,
					NotificationConstants.UNLOCK_PRESENTATION_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.BEGIN_PRESENTATION_EDIT:
					//presentationVO = PresentationVO( note.getBody() );
					view.presentationVO = PresentationVO( note.getBody() );
					proxy.getSlides( view.presentationVO.presentation_id );
					break;
				case NotificationConstants.GET_SLIDES_OK:
					view.presentationVO.slidesArray = note.getBody() as Array;
					break;
				case NotificationConstants.UNLOCK_PRESENTATION_OK:
					sendNotification( NotificationConstants.BACK_TO_SUBJECT_MANAGER );
					break;
				default:
					break;
			}
		}
		
		private function backBtnClick(event:MouseEvent):void {
			subjectManagerProxy.unlockPresentation( view.presentationVO.presentation_id );
		}
	}
}