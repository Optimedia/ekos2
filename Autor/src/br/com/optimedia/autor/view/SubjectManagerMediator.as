package br.com.optimedia.autor.view
{
	import br.com.optimedia.autor.assets.NotificationConstants;
	import br.com.optimedia.autor.assets.vo.PresentationVO;
	import br.com.optimedia.autor.assets.vo.SubjectVO;
	import br.com.optimedia.autor.model.SubjectManagerProxy;
	import br.com.optimedia.autor.view.components.SubjectManager;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class SubjectManagerMediator extends Mediator
	{
		public static const NAME:String = 'SubjectManagerMediator';
		
		private var subjectManagerProxy:SubjectManagerProxy;
		
		public function SubjectManagerMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void
		{
			trace(NAME+".onRegister()");
			
			view.addEventListener( SubjectManager.SAVE_SUBJECT_EVENT, saveSubject );
			view.addEventListener( SubjectManager.SAVE_PRESENTATION_EVENT, savePresentation );
			view.addEventListener( SubjectManager.DELETE_SUBJECT_EVENT, deleteSubject );
			view.addEventListener( SubjectManager.DELETE_PRESENTATION_EVENT, deletePresentation );
			view.slideEditBtn.addEventListener( MouseEvent.CLICK, slideEditBtnClick );
			
			subjectManagerProxy = facade.retrieveProxy( SubjectManagerProxy.NAME ) as SubjectManagerProxy;
			subjectManagerProxy.getSubjects();
			view.presentationSkins = subjectManagerProxy.presentationSkins;
		}
		
		override public function onRemove():void {
			
		}
		
		public function get view():SubjectManager
		{
			return viewComponent as SubjectManager;
		}
		
		override public function listNotificationInterests():Array
		{
			return [NotificationConstants.GET_SUBJECTS_OK,
					NotificationConstants.SAVE_SUBJECT_OK,
					NotificationConstants.SAVE_PRESENTATION_OK,
					NotificationConstants.LOCK_PRESENTATION_OK];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch (note.getName())
			{
				case NotificationConstants.GET_SUBJECTS_OK:
					var subjectSelectedIndex:int = view.subjectGrid.selectedIndex;
					var presentationSelectedIndex:int = view.presentationGrid.selectedIndex;
					view.subjectArray = new ArrayCollection(note.getBody() as Array);
					view.subjectGrid.selectedIndex = subjectSelectedIndex;
					view.presentationGrid.selectedIndex = presentationSelectedIndex;
					break;
				case NotificationConstants.SAVE_SUBJECT_OK:
					Alert.show("Módulo salvo com sucesso.", "OK");
					view.newSubjectPopUp.closeMe();
					break;
				case NotificationConstants.SAVE_PRESENTATION_OK:
					Alert.show("Tema salvo com sucesso.", "OK");
					view.newPresentationPopUp.closeMe();
					break;
				case NotificationConstants.LOCK_PRESENTATION_OK:
					sendNotification( NotificationConstants.BEGIN_PRESENTATION_EDIT, PresentationVO(view.presentationGrid.selectedItem) );
					break;
				default:
					break;
			}
		}
		
		private function saveSubject(event:Event):void {
			subjectManagerProxy.saveSubject( view.newSubjectPopUp.subjectVO );
		}
		
		private function savePresentation(event:Event):void {
			subjectManagerProxy.savePresentation( view.newPresentationPopUp.presentationVO );
		}
		
		private function deleteSubject(event:Event):void {
			subjectManagerProxy.deleteSubject( view.subjectGrid.selectedItem as SubjectVO );
		}
		
		private function deletePresentation(event:Event):void {
			subjectManagerProxy.deletePresentation( view.presentationGrid.selectedItem as PresentationVO );
		}
		
		private function slideEditBtnClick(event:MouseEvent):void {
			Alert.show("FINISH SubjectManagerMediator.slideEditBtnClick")
			// FALTA COLOCAR O USER ID NO lockPresentation
			subjectManagerProxy.lockPresentation( PresentationVO(view.presentationGrid.selectedItem).presentation_id, 1 );
			//sendNotification( NotificationConstants.BEGIN_PRESENTATION_EDIT, PresentationVO(view.presentationGrid.selectedItem) );
		}
	}
}